Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318782AbSILXHb>; Thu, 12 Sep 2002 19:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318774AbSILXHb>; Thu, 12 Sep 2002 19:07:31 -0400
Received: from CPE-203-51-30-83.nsw.bigpond.net.au ([203.51.30.83]:11259 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S318782AbSILXHa>; Thu, 12 Sep 2002 19:07:30 -0400
Message-ID: <3D811F4F.EF8BECCD@eyal.emu.id.au>
Date: Fri, 13 Sep 2002 09:12:15 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre5-ac6
References: <200209121555.g8CFt9G22831@devserv.devel.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------4668FD5DDFFEF30A68CCB481"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4668FD5DDFFEF30A68CCB481
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

drivers/scsi/cpqfcTS.h
======================

Has a stray tab after the eol backslash

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------4668FD5DDFFEF30A68CCB481
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre5-ac6-cpqfcTS.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre5-ac6-cpqfcTS.patch"

--- linux/drivers/scsi/cpqfcTS.h.orig	Fri Sep 13 08:34:19 2002
+++ linux/drivers/scsi/cpqfcTS.h	Fri Sep 13 08:34:31 2002
@@ -19,7 +19,7 @@
 // linked list of infinite length (with linked Ext S/G pages,
 // limited only by available physical memory) we use SG_ALL.
 
-#define CPQFCTS {                                \	
+#define CPQFCTS {                                \
 	detect:                 cpqfcTS_detect,         \
 	release:                cpqfcTS_release,        \
 	info:                   cpqfcTS_info,           \

--------------4668FD5DDFFEF30A68CCB481--

