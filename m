Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTAIB2s>; Wed, 8 Jan 2003 20:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbTAIB2s>; Wed, 8 Jan 2003 20:28:48 -0500
Received: from mta8.algx.net ([67.92.168.237]:29505 "EHLO chimta03.algx.net")
	by vger.kernel.org with ESMTP id <S261290AbTAIB2r>;
	Wed, 8 Jan 2003 20:28:47 -0500
Date: Wed, 08 Jan 2003 17:37:08 -0800
From: "studio3arc.com Admin" <admin@studio3arc.com>
Subject: RE: modutils x 2.5.54 almost there .. Generate-modprobe.conf not
 working
In-reply-to: <002b01c2b77b$c35e6900$61a1ba40@Henrique>
To: "'Henrique Gobbi'" <henrique.gobbi@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <000001c2b77f$9f9e0c60$6601a8c0@s3ac>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-Mailer: Microsoft Outlook, Build 10.0.2616
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>     <ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules/>
> 
> and read the README of this package.
> 
>

I'm almost there the onlyt problem is generate-modprobe.conf isnt'
working see the following command output..


s3a-www:~/module-init-tools-0.9.7/module-init-tools-0.9.7 # bash -x
./generate-modprobe.conf /etc/modprobe.conf
+ '[' 1 -gt 1 -o x/etc/modprobe.conf = x--help ']'
+ '[' 1 -eq 2 ']'
++ mktemp
Usage: mktemp [-d] [-q] [-u] template
+ MODPROBECONF=
+ '[' x '!=' x ']'
+ '[' -x /sbin/modprobe.old ']'
+ /sbin/modprobe.old -c
./generate-modprobe.conf: $MODPROBECONF: ambiguous redirect
+ IN_IF=0
+ CONVERTING=1
./generate-modprobe.conf: $MODPROBECONF: ambiguous redirect
++ echo
++ tr ' ' '\n'
++ sort -u
++ echo
++ tr ' ' '\n'
++ sort -u
s3a-www:~/module-init-tools-0.9.7/module-init-tools-0.9.7 #

