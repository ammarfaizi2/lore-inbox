Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317380AbSFRKh1>; Tue, 18 Jun 2002 06:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317381AbSFRKh0>; Tue, 18 Jun 2002 06:37:26 -0400
Received: from cm61-18-96-140.hkcable.com.hk ([61.18.96.140]:12 "EHLO
	mail.tropic.net") by vger.kernel.org with ESMTP id <S317380AbSFRKh0>;
	Tue, 18 Jun 2002 06:37:26 -0400
Message-ID: <009401c216b4$22458160$252ca8c0@sdfg>
From: "Hans E. Kristiansen" <hans@tropic.net>
To: <linux-kernel@vger.kernel.org>
References: <E17KDOn-0004vs-00@pmenage-dt.ensim.com> <20020618075118.GN22427@clusterfs.com>
Subject: 2.5.22 problems with compile.h
Date: Tue, 18 Jun 2002 18:36:36 +0800
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

I really need some help with compiling version 2.5.22

>From a clean install, I can compile, but I get an error with compile.h (Do
not know how to make compile.h). If I compile again, I get a working kernel
(bzImage), "depmod -ae -F xx " works like a charm. But, when I reboot with
the new kernel, I can not load any modules. None, they all have symbol
problems.

I use grub for loading, and I have verified that I have the correct
System.map

My last kernel is 2.5.19, which works like a charm ( well... ).

To compile a kernel, I use "make dep clean bzImage modules modules_install",
except for the first compile after an upgrade where I run "make oldconfig"
first.

Thanks,
Hans E.


