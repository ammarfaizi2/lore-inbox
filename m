Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbUL1P2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbUL1P2Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 10:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUL1P2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 10:28:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11705 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261251AbUL1P2U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 10:28:20 -0500
Date: Tue, 28 Dec 2004 07:17:29 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Larry McVoy <lm@work.bitmover.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK] disconnected operation
Message-ID: <20041228091728.GA24507@logos.cnet>
References: <1104077531.5268.32.camel@mulgrave> <20041226162727.GA27116@work.bitmover.com> <1104079394.5268.34.camel@mulgrave> <20041226171900.GA27706@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041226171900.GA27706@work.bitmover.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2004 at 09:19:00AM -0800, Larry McVoy wrote:
> On Sun, Dec 26, 2004 at 10:43:13AM -0600, James Bottomley wrote:
> > On Sun, 2004-12-26 at 08:27 -0800, Larry McVoy wrote:
> > > I suspect that your hostname changes when you disconnect.  Leases are 
> > > issued on a per host basis.  If you make your hostname constant when
> > > you unplug it should work.  If it doesn't, let us know.
> > 
> > Well, that's a new one, but no, I have a fixed hostname which dhcp is
> > forbidden from changing.
> 
> Let's do a little poll here to find out if it is specific to you or if
> this is a problem that everyone is having.  Could we get people who
> use BK disconnected to stand up and be counted?  Does this work for 
> anyone?
> 
> For James, could you do a little debugging please?  Run the following
> when you are plugged in and it works and also when it doesn't:
> 
> 	bk getuser
> 	bk getuser -r
> 	bk gethost
> 	bk gethost -r
> 	bk dotbk
> 
> We'll track it down and fix it if it is a problem on our end.  This stuff
> is supposed to work, we certainly haven't intentionally caused a problem.

Larry,

I have never been able to use BK in disconnected mode, which is very annoying.

It fails to connect to lease.openlogging.org as James describes.

Is disconnected operation supposed to work ? It didnt seem so.

