Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314409AbSEUMgB>; Tue, 21 May 2002 08:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314422AbSEUMgA>; Tue, 21 May 2002 08:36:00 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:28665 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S314409AbSEUMf6>; Tue, 21 May 2002 08:35:58 -0400
Message-ID: <000d01c200c4$4d0b9570$5132a8c0@AVANSUN.COM>
From: "Claude Lamy" <clamy@sunrisetelecom.com>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: /usr/include/asm/system.h
Date: Tue, 21 May 2002 08:37:42 -0400
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


----- Original Message -----
From: "Rupert Wood" <me@rupey.net>
To: "'Claude Lamy'" <clamy@sunrisetelecom.com>
Cc: <gcc-help@gcc.gnu.org>
Sent: Thursday, May 09, 2002 8:12 AM
Subject: RE: /usr/include/asm/system.h


> Claude Lamy wrote:
>
> > I am running a Mandrake 8.1 linux distribution with gcc 2.96.  In
> > the file /usr/include/asm/system.h, the function __cmpxchg uses a
> > parameter named "new" which is a reserved keyword in C++.  I can
> > modify the header file for myself but I think it should be changed (if
not
> > already) for future releases.
>
> Actually the system headers belong to the system C library and not GCC;
> in this case, however, that file belongs to the linux kernel
> (linux/include/asm-i386/system.h).
>
> It still contains 'new' in the latest 2.4 and 2.5 kernel trees. You may
> wish to report it to them instead.
>
> I'm not well up enough on the C and C++ standards to know if this is
> really a problem - there may be ways that it's supposed to compile
> anyway, and it appears to have survived for some time.
>
> Rup.

