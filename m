Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUAaXS6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 18:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUAaXS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 18:18:58 -0500
Received: from nms.rz.uni-kiel.de ([134.245.1.2]:29931 "EHLO uni-kiel.de")
	by vger.kernel.org with ESMTP id S265152AbUAaXS4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 18:18:56 -0500
From: Mike Gabriel <mgabriel@ecology.uni-kiel.de>
Reply-To: mgabriel@ecology.uni-kiel.de
To: linux-kernel@vger.kernel.org
Subject: page allocation failed in 2.4.24
Date: Sun, 1 Feb 2004 00:18:23 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200402010018.23725.mgabriel@ecology.uni-kiel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi there,

can anyone tell me what these messages mean? running linux-2.4.24 on asus 
p4p800 deluxe.

Jan 31 02:38:02 galileo kernel: __alloc_pages: 0-order allocation failed 
(gfp=0xf0/0)
Jan 31 02:38:02 galileo kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1d2/0)
Jan 31 02:38:02 galileo kernel: VM: killing process slapd
Jan 31 02:38:50 galileo kernel: __alloc_pages: 0-order allocation failed 
(gfp=0xf0/0)
Jan 31 02:38:50 galileo kernel: ENOMEM in journal_get_undo_access_R9add2900, 
retrying.
Jan 31 02:38:53 galileo kernel: __alloc_pages: 0-order allocation failed 
(gfp=0xf0/0)
Jan 31 02:39:19 galileo last message repeated 3 times
Jan 31 02:39:25 galileo kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1d2/0)
Jan 31 02:39:25 galileo kernel: VM: killing process sshd
Jan 31 02:39:25 galileo kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1d2/0)
Jan 31 02:39:25 galileo kernel: VM: killing process sshd

I get plenty of them during copying (cp -av <source> <dest>) a huge amount of 
data, which is densely filled with hard links from one raid to another... the 
cp command runs in a screen session. on huge directories, it starts blasting 
other processes from the system (sshd, nmbd, spong-client, etc.)

any ideas?
mike



-- 

Oekologiezentrum
Christian-Albrecht-Universität zu Kiel
- netzwerkteam -
Mike Gabriel
Olshausenstr 75.
24118 Kiel

fon: +49 431 880-1186
mail: mgabriel@ecology.uni-kiel.de
www: http://www.ecology.uni-kiel.de, http://zope.ecology.uni-kiel.de
     

