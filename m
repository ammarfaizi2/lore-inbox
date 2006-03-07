Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWCGQQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWCGQQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 11:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWCGQQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 11:16:27 -0500
Received: from xenotime.net ([66.160.160.81]:8864 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750840AbWCGQQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 11:16:27 -0500
Date: Tue, 7 Mar 2006 08:18:06 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Reg Clemens <reg@dwf.com>
Cc: rlrevell@joe-job.com, reg@dwf.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, reg@deneb.dwf.com
Subject: Re: vmlinuz-2.6.16-rc5-git8 still nogo with Intel D945 Motherboard
Message-Id: <20060307081806.0af1d2c4.rdunlap@xenotime.net>
In-Reply-To: <200603070823.k278NE9o006674@deneb.dwf.com>
References: <200603070340.k273ev0A003594@deneb.dwf.com>
	<1141703317.25487.142.camel@mindpipe>
	<200603070823.k278NE9o006674@deneb.dwf.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2006 01:23:14 -0700 Reg Clemens wrote:

> > On Mon, 2006-03-06 at 20:40 -0700, Reg Clemens wrote:
> > > 
> > > Anyone working this problem? 
> > 
> > Why don't you try to narrow it down some?
> > 
> 
> For what its worth, this is a D945GNT

I have one of the 3 variants of that board.

> It has ICH7 series Video/Sound/Ethernet on board.
> The Video works in vesa mode, but not in native mode.
> The sound is not recognized.

The HD (high-definition) audio driver works for me.
Are you using a vendor/distro kernel or roll-your-own?

> The ethernet is recognized by some kernels, but does not work.

Maybe try the latest e1000 driver from
  http://sourceforge.net/projects/e1000/

> It has ATA and SATA which both work.
> 
> My sound card is a Nvidia 6600, it works fine with 2.6.11.
> 
> At the moment I run with a 2.6.11 kernel, an ethernet card and a Soundblaster.
> Other than the Onboard hardware not being supported, things work with the
> 2.6.11 kernel.  this PCI error only occurs with later kernels.

Can you post the complete boot log instead of one line of it?

> I could play halfsies to determine just when the PCI error starts, but
> another responder had noted that he had similar problems after some
> 'large PCI changes'  (Im sure he mentioned what version they occurred
> in, but it would take some searching to find his e-mail)

---
~Randy
