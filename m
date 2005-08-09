Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVHIPYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVHIPYB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 11:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbVHIPYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 11:24:01 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:49348 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964818AbVHIPYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 11:24:00 -0400
Subject: Re: Soft lockup in e100 driver ?
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1123599524.30101.7.camel@mindpipe>
References: <20050809133647.GK22165@mea-ext.zmailer.org>
	 <1123599524.30101.7.camel@mindpipe>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 09 Aug 2005 11:23:49 -0400
Message-Id: <1123601029.18332.162.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 10:58 -0400, Lee Revell wrote:
> On Tue, 2005-08-09 at 16:36 +0300, Matti Aarnio wrote:
> > Running very recent Fedora Core Development kernel I can following
> > soft-oops..   ( 2.6.12-1.1455_FC5smp )
> > 
> > 
> > e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
> > BUG: soft lockup detected on CPU#0!
> 
> Could this be a false positive?  It's suspicious that the soft lockup
> detector was just merged to mainline then you got this.

I just downloaded 2.6.13-rc6-git and I don't see the merge of the soft
lockup code.  Is this a Fedora thing?  If so, could someone point me to
a link to download this Fedora kernel. I'm currently using Debian.

-- Steve


