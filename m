Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbSI0GSV>; Fri, 27 Sep 2002 02:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbSI0GSV>; Fri, 27 Sep 2002 02:18:21 -0400
Received: from bgp01116664bgs.westln01.mi.comcast.net ([68.42.104.18]:33824
	"HELO blackmagik.dynup.net") by vger.kernel.org with SMTP
	id <S261640AbSI0GSS>; Fri, 27 Sep 2002 02:18:18 -0400
Subject: [BUG]: linux-2.5.38 compile error with frame buffer support enabled]
From: Eric Blade <eblade@blackmagik.dynup.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-0O0sebeXCKie/Zcfj18w"
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 27 Sep 2002 02:19:13 -0400
Message-Id: <1033107553.1869.87.camel@cpq>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0O0sebeXCKie/Zcfj18w
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

umm.. forgot to send this to the list originally

sorry .. i'm a n00b.



--=-0O0sebeXCKie/Zcfj18w
Content-Disposition: inline
Content-Description: Forwarded message - FW: [BUG]: linux-2.5.38 compile
	error with frame buffer support enabled
Content-Type: message/rfc822

ReturnPath: <tarkane@solmaz.com.tr>
Received: from viruswall by blackmagik.dynup.net for
	<eblade@blackmagik.dynup.net>; Fri, 27 Sep 2002 02:18:15 +0GMT
Received: from 172.16.0.4 by viruswall (InterScan E-Mail VirusWall NT);
	Fri, 27 Sep 2002 09:13:33 +0300
Message-ID: <000f01c265ed$a6ff5100$040010ac@LocalHost>
From: "Tarkan Erimer" <tarkane@solmaz.com.tr>
To: <eblade@blackmagik.dynup.net>
Subject: FW: [BUG]: linux-2.5.38 compile error with frame buffer support
	enabled
Date: Fri, 27 Sep 2002 09:18:10 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2014.211
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2014.211



-----Original Message-----
From: Eric Blade [SMTP:eblade@blackmagik.dynup.net]
Sent: Friday, September 27, 2002 5:00 AM
To: Tarkan Erimer
Subject: Re: [BUG]: linux-2.5.38 compile error with frame buffer support
enabled

On Thu, 2002-09-26 at 04:16, Tarkan Erimer wrote:
> I tried to compile linux-2.5.38 with Frame-buffer support enabled.
> I chose the "nVidia Riva support" in "Frame-buffer support" section.
> Making "make dep clean" works OK. But, when I began "make bzImage",
> I got the following error message, which is attached to this mail via
> "error.log". I, also attached my ".config" file and "ver_linux" output.
> I hope, these help to resolve this problem. If need more info, please
> mail me.

Almost the exact same thing happens with the Radeon fb driver as well -
I have just tuned into this version as far as development goes (I
haven't even LOOKED at kernel source code in ten years, so I'm pretty
lost!) - but it appears to me that at some point during the 2.5.x tree,
a lot of the structure in the base framebuffer code has changed
drastically, and the nVidia and Radeon (among perhaps others) driver
code hasn't been updated to agree with it.

I'd be willing to do some work on the Radeon driver - does anyone know
of a document hiding somewhere on the web, or in back issues of LKML
that documents exactly what changed, and how to accomodate for it in the
other FB device drivers?

 - Eric





--=-0O0sebeXCKie/Zcfj18w--


