Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314483AbSEHPpK>; Wed, 8 May 2002 11:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314486AbSEHPpJ>; Wed, 8 May 2002 11:45:09 -0400
Received: from hdlc-ln.gsc-game.kiev.ua ([62.244.16.254]:46597 "EHLO
	redhat.gsc-game.kiev.ua") by vger.kernel.org with ESMTP
	id <S314483AbSEHPpI>; Wed, 8 May 2002 11:45:08 -0400
Message-ID: <004401c1f6a7$98f06ff0$e310f43e@manowar>
From: "Serguei I. Ivantsov" <admin@gsc-game.kiev.ua>
To: "Der Herr Hofrat" <der.herr@mail.hofr.at>
Cc: <linux-gcc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <200205081200.g48C0a805476@hofr.at>
Subject: Re: Measure time
Date: Wed, 8 May 2002 18:46:53 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any function like GetTickCount() in M$ Win32 that retrieves time in
milliseconds?

--
 Regards,
  Serguei I. Ivantsov

----- Original Message -----
From: "Der Herr Hofrat" <der.herr@mail.hofr.at>
To: "Serguei I. Ivantsov" <administrator@svitonline.com>
Cc: <linux-gcc@vger.kernel.org>; <linux-kernel@vger.kernel.org>
Sent: Wednesday, May 08, 2002 3:00 PM
Subject: Re: Measure time


> > Hello!
> >
> > Is there any function for high precision time measuring.
> > time() returns only in second. I need nanoseconds.
> >
> you can directly read the TSC but that will not realy give you nanoseconds
> resolution as the actual read access even on a PIII/1GHz is going to take
> up to a few 100 nanoseconds, and depending on what you want to time
> stamp the overall jitter of that code can easaly be in the
> range of a microsecond.
>
> There are some hard-realtime patches to the Linux kernel that will
> allow time precission of aprox. 1us (the TSC has a precission of 32ns)
> but I don't think you can get below that without dedicated hardware.
>
> for RTLinux check at ftp://ftp.rtlinux.org/pub/rtlinux/
>
> hofrat

