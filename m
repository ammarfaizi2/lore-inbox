Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSEVNYK>; Wed, 22 May 2002 09:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313242AbSEVNYJ>; Wed, 22 May 2002 09:24:09 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31504 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313202AbSEVNYI>; Wed, 22 May 2002 09:24:08 -0400
Subject: Re: i2c-old.h missing in 2.5.15-2.5.16
To: Peter@maersk-moller.net (Peter Maersk-Moller)
Date: Wed, 22 May 2002 14:11:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CEB5A9C.A3602DC2@maersk-moller.net> from "Peter Maersk-Moller" at May 22, 2002 10:45:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AVty-0001am-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Noticed that while trying to compile 2.5.15 and 2.5.16, then some of the drivers
> (forgot which - maybe i2c-something it self) requires existence of linux/i2c-old.h,
> but linux/i2c-old.h seems to have been excluded. Adding linux/i2c-old.h enables
> a succesfull compiling of the kernel, but maybe it was left out intentionally.

i2c-old has been scheduled for removal for two years and has now gone. Port
the drivers using it to the newer i2c code. Its not too tricky. Compare the
2.2 and current saa5249.c for a worked example
