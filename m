Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261570AbSJUSaO>; Mon, 21 Oct 2002 14:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261579AbSJUSaO>; Mon, 21 Oct 2002 14:30:14 -0400
Received: from moe.rice.edu ([128.42.5.4]:50035 "EHLO moe.rice.edu")
	by vger.kernel.org with ESMTP id <S261571AbSJUSaM>;
	Mon, 21 Oct 2002 14:30:12 -0400
Message-ID: <008801c27930$f35a55d0$e6fd000a@OMIT>
From: "omit_ECE" <omit@rice.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Problem in making modules_install
Date: Mon, 21 Oct 2002 13:37:23 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When recompiling the kernel in making modules_install, I got the messages as below,

cd /lib/modules/2.4.18-3custom; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.18-3custom; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.18-3custom/kernel/fs/binfmt_elf.o
depmod:         task_nice
make: *** [_modinst_post] Error 1

How could I do for this? Thank you.

YuZen
