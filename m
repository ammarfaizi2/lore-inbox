Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSGJNna>; Wed, 10 Jul 2002 09:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSGJNn3>; Wed, 10 Jul 2002 09:43:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15372 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315198AbSGJNn0>; Wed, 10 Jul 2002 09:43:26 -0400
Subject: Re: oops in 2.4.19-rc1
To: generica@email.com (Brett)
Date: Wed, 10 Jul 2002 15:09:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0207102259150.7269-100000@bad-sports.com> from "Brett" at Jul 10, 2002 11:01:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17SI9O-00077J-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, the kernel is tainted, thanks to NVdriver
> I booted with it, changed X to use nv driver and restarted X, so kernel 
> stayed tainted, but module is no longer loaded.

The module could have done the damage already. Do this from a cold
boot never loading the NV driver. The crash looks like memory corruption
so its important to do this and may also be worth running memtest86 a bit
