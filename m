Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272897AbRIPWD4>; Sun, 16 Sep 2001 18:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272875AbRIPWDq>; Sun, 16 Sep 2001 18:03:46 -0400
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:8978 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S272873AbRIPWDj>; Sun, 16 Sep 2001 18:03:39 -0400
Subject: Re: parse error on compiling a 2.4.9 kernel
From: Richard Russon <ntfs@flatcap.org>
To: james bond <difda@hotmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, fils_ubu@noos.fr
In-Reply-To: <LAW2-F141I1wvaKHY5U00005080@hotmail.com>
In-Reply-To: <LAW2-F141I1wvaKHY5U00005080@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.16.07.08 (Preview Release)
Date: 16 Sep 2001 23:04:01 +0100
Message-Id: <1000677842.8543.3.camel@home.flatcap.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> when i configure my kernel i select ntfs support and then i launch a 
> compiling process "make dep , make clean , make bzImage "
> and then i have this message :
> unistr.c: In function `ntfs_collate_names':
> ...

Yeah, it's a known problem.  Simply add the following line to unistr.c

  #include <linux/kernel.h>

Cheers,
  FlatCap (Rich)
  ntfs@flatcap.org



