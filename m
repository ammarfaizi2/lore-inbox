Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293422AbSCEQ2u>; Tue, 5 Mar 2002 11:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293424AbSCEQ2b>; Tue, 5 Mar 2002 11:28:31 -0500
Received: from irmgard.exp-math.uni-essen.de ([132.252.150.18]:47887 "EHLO
	irmgard.exp-math.uni-essen.de") by vger.kernel.org with ESMTP
	id <S293422AbSCEQ2W> convert rfc822-to-8bit; Tue, 5 Mar 2002 11:28:22 -0500
Date: Tue, 5 Mar 2002 17:28:12 +0100 (MEZ)
From: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Cc: Greg KH <greg@kroah.com>, Carl-Johan Kjellander <carljohan@kjellander.com>,
        linux-kernel@vger.kernel.org
Subject: Re: pwc-webcam attached to usb-ohci card blocks on read() indefinitely.
In-Reply-To: <200203051612.g25GCtc23752@fachschaft.cup.uni-muenchen.de>
Message-Id: <Pine.A32.3.95.1020305172410.29684G-100000@werner.exp-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Oliver Neukum wrote:

> Am Dienstag, 5. März 2002 06:11 schrieb Greg KH:
> > On Tue, Mar 05, 2002 at 02:06:07AM +0100, Carl-Johan Kjellander wrote:
> > > Attached to each one of these is an Philips ToUCam pro which uses the pwc
> > > and pwcx modules. (yes, the kernel becomes tainted by the pwcx module)
> >
> > As you are using this closed source module, I suggest you take this up
> > with that module's author.
> 
> Perhaps you could first ask whether the hang can be reproduced
> without that module loaded ?
> Secondly, that module is unlikely to cause that kind of trouble.

I might completely misunderstand the thread, but I would suspect the
pwc and pwcx modules to be the drivers for the pwc-webcam which blocks
forever on read syscalls.

How would you perform the read on the pwc-webcam w/o that driver module?

Michael.

--

Michael Weller: eowmob@exp-math.uni-essen.de, eowmob@ms.exp-math.uni-essen.de,
or even mat42b@spi.power.uni-essen.de. If you encounter an eowmob account on
any machine in the net, it's very likely it's me.

