Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWG0RJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWG0RJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWG0RJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:09:28 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:17857 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751774AbWG0RJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:09:27 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [PATCH] documentation: Documentation/initrd.txt
To: Tom Horsley <tom.horsley@ccur.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Thu, 27 Jul 2006 19:08:39 +0200
References: <6DfYt-7zU-49@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G69M4-0001Um-Jg@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(now CCing the list, too)

Tom Horsley <tom.horsley@ccur.com> wrote:

> I spent a long time the other day trying to examine an initrd
> image on a fedora core 5 system because the initrd.txt file
> is apparently obsolete. Here is a patch which I hope
> will reduce future confusion for others.

Your documentation is technically wrong, and there is a better explanation:

Signed-Off-By: Bodo Eggert <7eggert@gmx.de>

--- 2.6.17/Documentation/initrd.txt.ori 2006-07-27 18:49:25.000000000 +0200
+++ 2.6.17/Documentation/initrd.txt     2006-07-27 18:58:19.000000000 +0200
@@ -15,6 +15,9 @@ initrd is mainly designed to allow syste
 where the kernel comes up with a minimum set of compiled-in drivers, and
 where additional modules are loaded from initrd.

+initrd has recently been obsoleted by initramfs, which is described in
+Documentation/filesystems/ramfs-rootfs-initramfs.txt.
+
 This document gives a brief overview of the use of initrd. A more detailed
 discussion of the boot process can be found in [1].

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
