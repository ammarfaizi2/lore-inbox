Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbUEKVGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUEKVGR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 17:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUEKVGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 17:06:17 -0400
Received: from [198.138.227.126] ([198.138.227.126]:1042 "EHLO
	server.cympak.com") by vger.kernel.org with ESMTP id S262045AbUEKVGP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 17:06:15 -0400
Message-ID: <1ec701c4379c$075d5700$4900a8c0@cympak.com>
From: "Slawomir Orlowski" <orlowscy@hotpop.com>
To: <linux-kernel@vger.kernel.org>
Subject: problem with kernel 2.4.26 installation
Date: Tue, 11 May 2004 17:07:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

I have got Dell server PowerEdge 2500 with dell installed RH 7.2 and
2.4.7-10 kernel (rpm installation).
I wanted to upgrade it to 2.4.26 from source.

So I have done like always:
make mrproper,
copied .config from 2.4.7 (did make menuconfig)
make dep, clean, bzImage, modules, modules_install, install

and I got:
"
bsetup.s: Assembler messages:
bsetup.s:2503: Warning: indirect lcall without `*'
Root device is (8, 8)
Boot sector 512 bytes.
Setup is 4768 bytes.
System is 835 kB
+ '[' -x /root/bin/installkernel ']'
+ '[' -x /sbin/installkernel ']'
+ exec /sbin/installkernel 2.4.26 bzImage /usr/src/linux-2.4.26/System.map
''
/etc/lilo.conf: No such file or directory
make[1]: *** [install] Error 1
make: *** [install] Error 2
"
vmlinuz, System.map was created but intrid was not created and grub.conf was
no upgraded I do not use lilo on this server, so why he wants to upgrade
lilo ?.

I would really appreciate if somebody could help me how to proceed
farther...
I'm really stuck.

Best regards
Slawomir Orlowski

