Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbTIJKPN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 06:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTIJKPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 06:15:13 -0400
Received: from hal-4.inet.it ([213.92.5.23]:45732 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id S261458AbTIJKPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 06:15:08 -0400
Message-ID: <022e01c37785$02690aa0$5aaf7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: "Arjan van de Ven" <arjanv@redhat.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <20030910095255.GA21313@mail.jlokier.co.uk> <20030910120729.C14352@devserv.devel.redhat.com>
Subject: Re: Efficient IPC mechanism on Linux
Date: Wed, 10 Sep 2003 12:17:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This test is sort of the worst case against my argument:
> 1) It's a cpu with low memory bandwidth
> 2) It's a 1 CPU system
> 3) It's a pII not pIV; the pII is way more efficient cycle wise
>    for pagetable operations

I'm a Compuer Science graduate. And at least one single thing I've learned
in my studies.
More efficient Firmware support
(such as an extremely wide memory bandwith
or tens of CPUs in an SMP/NUMA
or efficient cache line transfer support)

DOES NOT ALLOW YOU TO WASTE CYCLES IN DOING USELESS THINGS,
such as TWO physical copies of a message if a process want to cooperate with
another one.

We are not engineer that simply have to let the things work.

That's all.
Luca.

