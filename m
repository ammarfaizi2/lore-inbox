Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275983AbRJGBSJ>; Sat, 6 Oct 2001 21:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRJGBR7>; Sat, 6 Oct 2001 21:17:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41527 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S275983AbRJGBRn>; Sat, 6 Oct 2001 21:17:43 -0400
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Thomas Hood" <jdthood@mail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux should not set the "PnP OS" boot flag
In-Reply-To: <E15pyjj-0002Kn-00@the-village.bc.nu>
From: ebiederman@uswest.net (Eric W. Biederman)
Date: 06 Oct 2001 19:08:21 -0600
In-Reply-To: <E15pyjj-0002Kn-00@the-village.bc.nu>
Message-ID: <m13d4wxnne.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alan Cox" <alan@lxorguk.ukuu.org.uk> writes:

> > Do you have any insite into what needs to be done so that the kernel
> > will automatically configure isa pnp devices?
> 
> We already configure isapnp devices. We don't yet configure all the PnPbios
> devices

O.k.  I'm getting more interested as I read this.  So we have things like
superio chips and the like with configureable resources, (and possibly some
pci<->isa bridge resources that need to bec onfigured.)

Coming from the linuxBIOS side I'm interested as that will allow me to
rip out more code, from linuxBIOS. And I think it is only sane to report
such devices.

I don't know about the stock BIOS interfaces to those devices though.  I'll
keep an eye on them and see what I can do.  Hopefully within the next couple
of mounths I can start attacking this problem.

Eric


