Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbTIHP0z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbTIHP0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:26:55 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:23565 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262629AbTIHP0b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:26:31 -0400
Message-Id: <200309081526.h88FQMjh029751@ccure.karaya.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Rus Foster <rghf@fsck.me.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: promblem compiling skas patch 
In-Reply-To: Your message of "Mon, 08 Sep 2003 04:04:24 PDT."
             <20030908040409.B61909@thor.65535.net> 
References: <20030908040409.B61909@thor.65535.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Sep 2003 11:26:22 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rghf@fsck.me.uk said:
> arch/i386/kernel/kernel.o: In function `sys_ptrace': 
> arch/i386/kernel/kernel.o(.text+0x50c9): undefined reference to `proc_mm_get_mm' 

This is a mistake in the patch which you can work around by enabling
CONFIG_PROC_MM.  The patch is kind of pointless if you don't turn that on.

				Jeff

