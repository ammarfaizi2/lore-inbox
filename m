Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbTDKJWD (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 05:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbTDKJWD (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 05:22:03 -0400
Received: from rj.sgi.com ([192.82.208.96]:35722 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261855AbTDKJWD (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 05:22:03 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: =?ISO-8859-1?Q?Pablo_Gim=E9nez_Pizarro?= <pablogipi@inicia.es>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Uresolved Symbol problem in kernel compiled for ATHLON :( 
In-reply-to: Your message of "Fri, 11 Apr 2003 13:12:38 +0200."
             <3E96A326.4040700@inicia.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 Apr 2003 19:33:29 +1000
Message-ID: <26598.1050053609@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Apr 2003 13:12:38 +0200, 
=?ISO-8859-1?Q?Pablo_Gim=E9nez_Pizarro?= <pablogipi@inicia.es> wrote:
>I've compiled a kernel optimized for aTHLON processors and when i reboot 
>i get the next error nwhen try to load some modules:
>
>/lib/modules/2.4.20/kernel/drivers/net/dmfe.o: unresolved symbol _mmx_memcpy

Broken kernel build system.  You must make mrproper before changing
processor type or when switching from SMP to UP or vice versa.

