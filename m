Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130473AbQLRUP2>; Mon, 18 Dec 2000 15:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129944AbQLRUPT>; Mon, 18 Dec 2000 15:15:19 -0500
Received: from uucp.nl.uu.net ([193.79.237.146]:26497 "EHLO uucp.nl.uu.net")
	by vger.kernel.org with ESMTP id <S129604AbQLRUPI>;
	Mon, 18 Dec 2000 15:15:08 -0500
Date: Mon, 18 Dec 2000 20:30:16 +0100 (CET)
From: kees <kees@schoen.nl>
To: linux-kernel@vger.kernel.org
Subject: old binary works not with 2.2.18
Message-ID: <Pine.LNX.4.21.0012182026170.8049-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an old 4GL application (from SCO3.2v4) that is a neat database
tool. Under 2.2.17 with iBCS this works well:

kees@renske1:~ > cat /proc/version
Linux version 2.2.17 (root@renske1) (gcc version 2.95.2 19991024
(release)) #10
Wed Dec 6 20:16:39 CET 2000
kees@renske1:~ > sage
 
sage : Screen language interpreter
 
SCULPTOR 4GL + SQL
Release 2.0b (30 May 1990)
(C) 1984-1990 Microprocessor Developments Ltd.
All rights reserved
   
However under 2.2.18 I get:

kees@schoen3:~ > cat /proc/version
Linux version 2.2.18 (root@schoen3) (gcc version 2.95.2 19991024
(release)) #1 SMP Mon Dec 18 00:48:04 CET 2000
kees@schoen3:~ > sage
Segmentation fault

schoen3:~ #  file /usr/SCULPTOR/bin/sage
/usr/SCULPTOR/bin/sage: Microsoft a.out separate pure segmented
word-swapped V2.3 V3.0 386 small model executable  

Hints?

Kees


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
