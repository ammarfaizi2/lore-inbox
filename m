Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261597AbSJFNV3>; Sun, 6 Oct 2002 09:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbSJFNV3>; Sun, 6 Oct 2002 09:21:29 -0400
Received: from 62-190-218-58.pdu.pipex.net ([62.190.218.58]:36360 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261597AbSJFNV3>; Sun, 6 Oct 2002 09:21:29 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210061335.g96DZld2002585@darkstar.example.net>
Subject: Re: Compiling old Linux
To: jarekp3@wp.pl (Jarek Pelczar)
Date: Sun, 6 Oct 2002 14:35:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001001c26d3b$67a80d80$c9d84dd5@domq9fpmpjxazs> from "Jarek Pelczar" at Oct 06, 2002 03:22:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi !
> 
> Does anybody know how to compile
> linux 0.12. It crashes in fork when I use GCC 3.1.

There is no way it will compile with a modern GCC, you need to use a compiler that was around at the time, (I have no idea what that would be!).

The reason is that both the kernel and GCC have bugs in them, and the kernel is generally coded to work around bugs in the current versions of GCC - so you can't use any compiler to compile any kernel.

John.
