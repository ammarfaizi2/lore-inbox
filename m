Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268006AbTBYQBO>; Tue, 25 Feb 2003 11:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268011AbTBYQBN>; Tue, 25 Feb 2003 11:01:13 -0500
Received: from air-2.osdl.org ([65.172.181.6]:664 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268006AbTBYQBN>;
	Tue, 25 Feb 2003 11:01:13 -0500
Date: Tue, 25 Feb 2003 08:07:00 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: tomlins@cam.org, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] uart_block_til_ready 2.5.63
Message-Id: <20030225080700.3a590cf7.rddunlap@osdl.org>
In-Reply-To: <20030225093544.B9257@flint.arm.linux.org.uk>
References: <200302242142.26124.tomlins@cam.org>
	<20030225093544.B9257@flint.arm.linux.org.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003 09:35:44 +0000
Russell King <rmk@arm.linux.org.uk> wrote:

| On Mon, Feb 24, 2003 at 09:42:25PM -0500, Ed Tomlinson wrote:
| > Feb 24 21:14:44 oscar kernel: Code: f6 80 1c 01 00 00 02 75 2d 8b 4d 08 51 e8 10 6e 00 00 85 c0
| 
| Can someone decode this Code: line into something useful please?
| (maybe we should put in an instruction decoder as well as kallsyms
| into the kernel? 8))

Is there a bingrep, so that you can grep for that binary string in
vmlinux (or whatever it's named)?

If not and you haven't already written one, you can use my
binoffset program for that.  It might help your search time.
It's at
  http://www.osdl.org/archive/rddunlap/patches/ikconfig/binoffset.c

--
~Randy
