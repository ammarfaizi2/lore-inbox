Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317180AbSF2GNZ>; Sat, 29 Jun 2002 02:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317192AbSF2GNZ>; Sat, 29 Jun 2002 02:13:25 -0400
Received: from CPE-203-51-28-152.nsw.bigpond.net.au ([203.51.28.152]:22264
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S317180AbSF2GNY>; Sat, 29 Jun 2002 02:13:24 -0400
Message-ID: <3D1D508D.BC352FB8@eyal.emu.id.au>
Date: Sat, 29 Jun 2002 16:15:41 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc1aa1
References: <20020629023459.GA1531@inspiron.ols.wavesec.org>
Content-Type: multipart/mixed;
 boundary="------------ED601B6F6FEDAFCB16AB2C89"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------ED601B6F6FEDAFCB16AB2C89
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Still (as in pre10-aa4) needed to patch:
	drivers/parport/parport_cs.c

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------ED601B6F6FEDAFCB16AB2C89
Content-Type: text/plain; charset=us-ascii;
 name="2.4.19-rc1-aa1-parport_cs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.19-rc1-aa1-parport_cs.patch"

*** linux/drivers/parport/parport_cs.c.orig	Sun Jun 23 09:20:21 2002
--- linux/drivers/parport/parport_cs.c	Sun Jun 23 09:21:02 2002
***************
*** 48,53 ****
--- 48,54 ----
  
  #include <linux/parport.h>
  #include <linux/parport_pc.h>
+ #include <linux/major.h>
  
  #include <pcmcia/version.h>
  #include <pcmcia/cs_types.h>

--------------ED601B6F6FEDAFCB16AB2C89--

