Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291642AbSBHXvs>; Fri, 8 Feb 2002 18:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287874AbSBHXvi>; Fri, 8 Feb 2002 18:51:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11014 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287860AbSBHXva>; Fri, 8 Feb 2002 18:51:30 -0500
Subject: Re: What "module license" applies to public domain code?
To: carson@antd.nist.gov (Mark E. Carson)
Date: Sat, 9 Feb 2002 00:05:00 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0202081632041.16834-100000@ran.antd.nist.gov> from "Mark E. Carson" at Feb 08, 2002 05:07:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ZL0m-0005QU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Of course, anyone else would be free to take the code and apply any
> license whatsoever to it, but my concern is simply what MODULE_LICENSE()
> line I can legitimately include, if any.

We have to be careful about this because MODULE_LICENSE("Public domain")
doesn't mean anything if the resulting code is then shipped binary only.
GPL and additional rights is probably closest or even just a

/*
 *	When linked into the Linux kernel the resulting work is GPL, you
 *	are however free to use this work under other licenses if you
 *	so wish. See README.blah
 */

MODULE_LICENSE("GPL");	/* When part of Linux */

