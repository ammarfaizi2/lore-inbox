Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbUAYTWH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbUAYTWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:22:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:25551 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265188AbUAYTWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:22:05 -0500
Date: Sun, 25 Jan 2004 11:19:59 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: jamagallon@able.es, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: mpspec.h, mach_mpspec.h
Message-Id: <20040125111959.431dff9d.rddunlap@osdl.org>
In-Reply-To: <20040125191106.GA3203@mars.ravnborg.org>
References: <20040125172904.GA3195@werewolf.able.es>
	<20040125191106.GA3203@mars.ravnborg.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jan 2004 20:11:06 +0100 Sam Ravnborg <sam@ravnborg.org> wrote:

| > 
| > Workaround is to add -I/usr/src/linux/include/asm/mach-default.
| 
| i386 at least always include:
| -Iinclude/asm-i386/mach-default
| Which should let gcc include the file in question.
| 
| Try to compile with V=1 and post the full command line to gcc.

JAM, how are you building the sensors modules?
I.e., is this just a "make modules" or are you building
modules that are outside of the kernel tree?

--
~Randy
