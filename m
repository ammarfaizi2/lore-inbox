Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265874AbUAPWO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 17:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265863AbUAPWNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 17:13:06 -0500
Received: from chaos.analogic.com ([204.178.40.224]:388 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265746AbUAPWDo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 17:03:44 -0500
Date: Fri, 16 Jan 2004 17:07:05 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ashish sddf <buff_boulder@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ kernel module + Makefile
In-Reply-To: <20040116210924.61545.qmail@web12008.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0401161659470.31455@chaos>
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jan 2004, Ashish sddf wrote:

> Hi,
>    I am trying to port a C++ kernel module from 2.4 to
> 2.6. (It is MIT Click Modular Router).
>
>    As I understand the module building has changed in
> ver 2.6. I have got the Makefile to compile it but it
> gives me lot of warning - all dependancies problem
>
>  It appears that the kernel Makefile treats it like a
> host application and does not pass the necessary
> processing routines.
>
>   Does anyone can ideas about how to change the kernel
> makefile to compile the C++ files the same way as C
> files ?
>
> Any help will be appreciated.
>
> Ashish

If somebody actually got a module, written in C++, to compile and
work on linux-2.4.nn, as you state, it works only by fiat, i.e., was
declared to work. There is no C++ runtime support in the kernel for
C++. Are you sure this is a module and not an application? Many
network processes (daemons) are applications and they don't require
any knowledge of kernel internals except what's provided by the
normal C/C++ include-files.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


