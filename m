Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317429AbSG3Xvr>; Tue, 30 Jul 2002 19:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317433AbSG3Xvr>; Tue, 30 Jul 2002 19:51:47 -0400
Received: from CPE-203-51-28-61.nsw.bigpond.net.au ([203.51.28.61]:49905 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S317429AbSG3Xvr>; Tue, 30 Jul 2002 19:51:47 -0400
Message-ID: <3D47275B.E89A8958@eyal.emu.id.au>
Date: Wed, 31 Jul 2002 09:55:07 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19rc3-ac5
References: <200207301356.g6UDuq900731@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
> 
> This patch contains SiS IDE updates. Usual caveats apply. The HP merge is
> now down to 5340 lines.
> 
> Linux 2.4.19rc3-ac5

I see wrong EXTRAVERSION:

--- linux.19rc3/Makefile        2002-07-29 12:54:46.000000000 +0100
+++ linux.19rc3-ac5/Makefile    2002-07-29 14:02:12.000000000 +0100
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 19
-EXTRAVERSION = -rc3
+EXTRAVERSION = -rc3-ac4

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
