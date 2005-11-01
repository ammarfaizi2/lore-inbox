Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbVKARWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbVKARWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbVKARWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:22:40 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:3247
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1750999AbVKARWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:22:39 -0500
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: dtor_core@ameritech.net
Cc: Robert Love <rml@novell.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel Badness 2.6.14-Git
Date: Tue, 1 Nov 2005 12:22:20 -0500
Message-Id: <20051101172007.M10804@linuxwireless.org>
In-Reply-To: <d120d5000511010838j2013f29et3d48d891e5ea8dad@mail.gmail.com>
References: <4362BFF1.3040304@linuxwireless.org> <200510312221.13217.dtor_core@ameritech.net> <20051101073530.GB27536@kroah.com> <200511010258.14313.dtor_core@ameritech.net> <20051101081433.GB28048@kroah.com> <1130854317.16163.52.camel@phantasy> <20051101144509.M10192@linuxwireless.org> <d120d5000511010838j2013f29et3d48d891e5ea8dad@mail.gmail.com>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.126.157.6 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005 11:38:51 -0500, Dmitry Torokhov wrote
> On 11/1/05, Alejandro Bonilla <abonilla@linuxwireless.org> wrote:
> > On Tue, 01 Nov 2005 09:11:57 -0500, Robert Love wrote
> > > On Tue, 2005-11-01 at 00:14 -0800, Greg KH wrote:
> > >
> > > > I don't have a problem with this, try it out and see what breaks :)
> > >
> > > I don't mind moving the driver (as Greg suggested earlier) if needed,
> > > but if Dmitry's idea to move input.o works, even better.
> > >
> >
> > I can try the suggested solution if I'm told how to. ;-)
> >
> 
> Could you try the attached (I did compile it but didn't try to boot).

  LD      drivers/video/built-in.o
  LD      drivers/w1/built-in.o
  LD      drivers/built-in.o
ld: drivers/input/input.o: No such file: No such file or directory
make[2]: *** [drivers/built-in.o] Error 1
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/root/linux-2.6'
make: *** [stamp-build] Error 2

I did a little fetch for Linus tree before patching, but it downloaded just a
couple of changes,  I'm now running a kernel that I compiled like 2 hours ago
after some major fetch from Linus. I think this error is because of the patch?

.Alejandro

> --
> Dmitry


