Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUDAOM1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 09:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbUDAOM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 09:12:27 -0500
Received: from host199.200-117-131.telecom.net.ar ([200.117.131.199]:44682
	"EHLO smtp.bensa.ar") by vger.kernel.org with ESMTP id S261746AbUDAOMZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 09:12:25 -0500
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.5-rc3-mm4
Date: Thu, 1 Apr 2004 11:12:20 -0300
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040401020512.0db54102.akpm@osdl.org>
In-Reply-To: <20040401020512.0db54102.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404011112.21212.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc3/2.6
>.5-rc3-mm4/

It fails here with:

	nbensa@venkman:/usr/src/linux$ sudo make
	make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
	  CHK     include/linux/compile.h
	Kernel: arch/i386/boot/bzImage is ready
	  Building modules, stage 2.
	  MODPOST
	LANG := en_US.UTF-8
	make: LANG: Command not found
	make: *** [all] Error 127

Workaround is:

	LC_ALL= sudo make

Regards,
Norberto
