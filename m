Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265580AbSJSKDD>; Sat, 19 Oct 2002 06:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265581AbSJSKDD>; Sat, 19 Oct 2002 06:03:03 -0400
Received: from mail.broadpark.no ([217.13.4.2]:3736 "HELO mail.broadpark.no")
	by vger.kernel.org with SMTP id <S265580AbSJSKDC>;
	Sat, 19 Oct 2002 06:03:02 -0400
Message-ID: <3DB12F8F.86C0B2E0@broadpark.no>
Date: Sat, 19 Oct 2002 12:10:23 +0200
From: Helge Hafting <helge.hafting@broadpark.no>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.5.7-dj2 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.44 compile failure, net/ipv4/raw.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,net/ipv4/.raw.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=raw   -c -o net/ipv4/raw.o net/ipv4/raw.c
net/ipv4/raw.c: In function `raw_send_hdrinc':
net/ipv4/raw.c:297: `NF_IP_LOCAL_OUT' undeclared (first use in this
function)
net/ipv4/raw.c:297: (Each undeclared identifier is reported only once
net/ipv4/raw.c:297: for each function it appears in.)
