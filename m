Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135293AbRANTrc>; Sun, 14 Jan 2001 14:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135338AbRANTrX>; Sun, 14 Jan 2001 14:47:23 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:64781 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S135293AbRANTrM>;
	Sun, 14 Jan 2001 14:47:12 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101141946.WAA25337@ms2.inr.ac.ru>
Subject: Re: Kernel oops in tcp_ipv4.c
To: pim@uknet.spacesurfer.com
Date: Sun, 14 Jan 2001 22:46:48 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A5F55AF.9651CCF1@spacesurfer.com> from "Patrick" at Jan 12, 1 10:15:02 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Recently I tried 2.2.17, this kernel was up for about a month, before
> there was a kernel oops. The syslog messages are:

This is caused by illegal setting of /proc/sys/net/ipv4/ip_local_port_range
with kernels before 2.2.18.

Do not touch this value or change it to something reasonable,
f.e. to one of values recommended in net/ipv4/tcp_ipv4.c

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
