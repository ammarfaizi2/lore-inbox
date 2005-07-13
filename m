Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVGMB3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVGMB3Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 21:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVGMB3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 21:29:23 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59560 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262189AbVGMB2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 21:28:10 -0400
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: William Weston <weston@sysex.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1121217531.26266.15.camel@mindpipe>
References: <200506281927.43959.annabellesgarden@yahoo.de>
	 <200506301952.22022.annabellesgarden@yahoo.de>
	 <20050630205029.GB1824@elte.hu>
	 <200507010027.33079.annabellesgarden@yahoo.de>
	 <20050701071850.GA18926@elte.hu>
	 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org>
	 <1120269723.12256.11.camel@mindpipe>
	 <Pine.LNX.4.58.0507040042220.31967@echo.lysdexia.org>
	 <20050704111648.GA11073@elte.hu>  <1121217531.26266.15.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 21:28:07 -0400
Message-Id: <1121218088.4435.0.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 21:18 -0400, Lee Revell wrote:
> On Mon, 2005-07-04 at 13:16 +0200, Ingo Molnar wrote:
> > i'd first suggest to try the latest kernel, before changing your X 
> > config - i think the bug might have been fixed meanwhile.
> 
> I have found that heavy network traffic really kills the interactive
> performance.  In the top excerpt below, gtk-gnutella is generating about
> 320KB/sec of traffic.
> 
> These priorities do not look right:

Never mind, I just rediscovered the RT priority leakage bug.

Lee

