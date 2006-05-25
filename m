Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWEYLF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWEYLF1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 07:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWEYLF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 07:05:27 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16088 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964977AbWEYLF0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 07:05:26 -0400
Subject: Re: drivers/char/rocket.c: somewhat broken since 2.6.16
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44757A09.8060603@tls.msk.ru>
References: <44757A09.8060603@tls.msk.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 25 May 2006 12:18:29 +0100
Message-Id: <1148555909.12482.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-05-25 at 13:34 +0400, Michael Tokarev wrote:
> I'm trying to use rocket.c from 2.6.15 on a 2.6.16 kernel now,
> let's see what will happen...  

I imagine it'll break spectacularly as the tty layer handling changed
between the two quite a bit. Do you know if the modem is receving the
characters as you typed and the echo is delayed or vice versa.

I do have one patch for the rocket driver to fix an obscure Oops case
but nothing else. I'm also hoping to help find a way that works for
comtrol and the kernel folks to get a current comtrol driver into the
tree in a way that they can maintain easily.

Please stick the bug into the kernel bugzilla and assign it to me. I'll
do a bit of digging see what is up

