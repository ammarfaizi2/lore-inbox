Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSH0TM4>; Tue, 27 Aug 2002 15:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSH0TMz>; Tue, 27 Aug 2002 15:12:55 -0400
Received: from chaos.analogic.com ([204.178.40.224]:59265 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317073AbSH0TMy>; Tue, 27 Aug 2002 15:12:54 -0400
Date: Tue, 27 Aug 2002 15:19:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "chen, xiangping" <chen_xiangping@emc.com>
cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is it possible to use 8K page size on a i386 pc?
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F550207819D@srgraham.eng.emc.com>
Message-ID: <Pine.LNX.3.95.1020827151608.10992B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2002, chen, xiangping wrote:

> Hi,
> 
> I just wonder how PAGE_SIZE in determined in each architecture? Is it
> possible to use 8k or bigger page size in a i386 PC?
> 
> Thanks,
> 
> Xiangping

It's hardware; "Because both the virtual pages in the linear
address space and the physical pages of memory are aligned to
4k page boundaries, there is no need to modify the low 12
bits of the address. These 12 bits pass straight through the
paging hardware, whether paging is enabled or not...."


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

