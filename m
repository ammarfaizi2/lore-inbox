Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbUBWQ7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbUBWQ7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:59:34 -0500
Received: from [213.78.110.125] ([213.78.110.125]:38785 "HELO stockwith.co.uk")
	by vger.kernel.org with SMTP id S261963AbUBWQ65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:58:57 -0500
From: Chris Lingard <chris@ukpost.com>
To: MALET JL <malet.jean-luc@laposte.net>
Subject: Re: [linux 2.6.3] [gcc 3.3.3] compile errors
Date: Mon, 23 Feb 2004 16:58:53 +0000
User-Agent: KMail/1.5.2
References: <403911B3.10601@laposte.net> <20040223074221.5f711665.rddunlap@osdl.org> <403A2ADB.9040002@laposte.net>
In-Reply-To: <403A2ADB.9040002@laposte.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402231658.53516.chris@ukpost.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 February 2004 4:31 pm, MALET JL wrote:

> copy from /usr/src/linux/include/asm to /usr/include/asm
> copy from /usr/src/linux/include/asm-generic to /usr/include/asm-generic
> copy from /usr/src/linux/include/linux to /usr/include/linux
>
> is this wrong ? I've done this all the time (since 2.4.2 kernel) without
> problem..... if i'm wrong please correct my behaviour

You should use the kernel headers to build glibc; and sanitised headers
such as RedHat's or http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
to build the rest of the system.  Suggest you follow www.linuxfromscratch.org 
for further details.

Chris
