Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270724AbRHWXda>; Thu, 23 Aug 2001 19:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270746AbRHWXdL>; Thu, 23 Aug 2001 19:33:11 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59148 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270724AbRHWXdJ>; Thu, 23 Aug 2001 19:33:09 -0400
Subject: Re: assembler -> linux system calls
To: Bart.Vandewoestyne@pandora.be (Bart Vandewoestyne)
Date: Fri, 24 Aug 2001 00:36:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B856E09.EAAE6564@pandora.be> from "Bart Vandewoestyne" at Aug 23, 2001 10:56:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15a41X-0004t1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could somebody tell me what function to use where the question marks
> are written?  Are the other mappings from inpl and outpl also correct?

The look like the inb/inw/outb/outw functions. Im not sure how DOS asm
maps byte and word sized in and out

swmem is a byte swap. There isnt a trivial equivalent because its almost
never the case you want to byteswap but you want to convert endiannesses
htons() will probably do the right thing while you figure it out
