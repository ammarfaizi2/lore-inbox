Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbVCDC6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbVCDC6n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbVCDCsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:48:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:719 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262785AbVCCXuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:50:23 -0500
Date: Thu, 3 Mar 2005 15:49:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mark Canter <marcus@vfxcomputing.com>
Cc: rlrevell@joe-job.com, nish.aravamudan@gmail.com, drzeus-list@drzeus.cx,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
Message-Id: <20050303154929.1abd0a62.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com>
References: <4227085C.7060104@drzeus.cx>
	<29495f1d05030309455a990c5b@mail.gmail.com>
	<Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
	<1109875926.2908.26.camel@mindpipe>
	<Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
	<1109876978.2908.31.camel@mindpipe>
	<Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Canter <marcus@vfxcomputing.com> wrote:
>
> 
> To close this issue out of the LKML and alsa-devel, a bug report has been 
> written.
> 
> It appears to be an issue with the 'headphone jack sense' (as kde labels 
> it).  The issue is in the way the 8x0 addresses the docking station/port 
> replicator's audio output jack.  The mentioned quick fix does not work for 
> using the ds/pr audio output, but does resolve it for a user that is only 
> using headphones/internal speakers.

But there was a behavioural change: applications which worked in 2.6.10
don't work in 2.6.11, is that correct?

If so, the best course of action is to change the kernel so those
applications work again.  Can that be done?

