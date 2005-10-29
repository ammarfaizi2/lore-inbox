Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932743AbVJ2X3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743AbVJ2X3N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 19:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbVJ2X3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 19:29:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:2789 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932736AbVJ2X3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 19:29:11 -0400
Date: Sat, 29 Oct 2005 16:28:39 -0700
From: Greg KH <greg@kroah.com>
To: Akula2 <akula2.shark@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-ID: <20051029232839.GA18845@kroah.com>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com> <20051029195115.GD14039@flint.arm.linux.org.uk> <Pine.LNX.4.64.0510291314100.3348@g5.osdl.org> <8355959a0510291344o663a2904nd828c90812f4ffb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8355959a0510291344o663a2904nd828c90812f4ffb5@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 02:14:39AM +0530, Akula2 wrote:
> Hi Linus,
> 
> This is my first mail to the Kernel tree:-
> 
> > Everything said, I think 2.6.13->14 worked well enough, even if it's hard
> > to say how well a process works after one release. Considering that 2.6.13
> > had the painful PCI changes (you may not have noticed too much, since they
> > were x86 only) and there were some potentially painful SCSI changes in the
> > .14 early merges, so it's not like 13->14 was an "easy" release - so the
> > process certainly _seems_ to be workable.
> 
> Will you please throw more light on the *painful* PCI & SCSI changees?

If it worked for you, it wasn't painful :)

But for PCI, we changed the way we did resource allocation for devices,
which caused a lot of odd problems on some machines.

thanks,

greg k-h
