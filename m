Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266397AbRGBHZV>; Mon, 2 Jul 2001 03:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266396AbRGBHZK>; Mon, 2 Jul 2001 03:25:10 -0400
Received: from [192.48.153.1] ([192.48.153.1]:58143 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S266395AbRGBHY7>;
	Mon, 2 Jul 2001 03:24:59 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Riley Williams <rhw@MemAlpha.CX>
cc: Russell King <rmk@arm.linux.org.uk>, Adam J Richter <adam@yggdrasil.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs 
In-Reply-To: Your message of "Mon, 02 Jul 2001 08:16:50 +0100."
             <Pine.LNX.4.33.0107020810340.18977-100000@infradead.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Jul 2001 17:23:42 +1000
Message-ID: <26219.994058622@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2001 08:16:50 +0100 (BST), 
Riley Williams <rhw@MemAlpha.CX> wrote:
> Q> dep_arch_tristate '  AM79C961A support' CONFIG_ARM_AM79C961A \
> Q>	"$CONFIG_ARCH_ACORN" $CONFIG_NET_ETHERNET
>
>That adds only two extra characters, neither conspicuous, and PASSES
>my code.

It relies on everybody writing new dep_arch_... rules to remember the
quotes.  You are just introducing another source of human error.  That
is how this mess occurred, no automatic validation of input.

