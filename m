Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbUCAD5c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 22:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbUCAD5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 22:57:32 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:20420 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262240AbUCAD5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 22:57:31 -0500
Date: Sun, 29 Feb 2004 22:57:22 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6] linux/README update 
In-Reply-To: <3596.1078111381@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.58.0402292255040.20214@montezuma.fsmlabs.com>
References: <3596.1078111381@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2004, Keith Owens wrote:

> On Fri, 27 Feb 2004 08:18:20 -0500 (EST),
> Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
> >- - You can use the "ksymoops" program to make sense of the dump.  This
> >-   utility can be downloaded from
> >+ - If you compiled the kernel with CONFIG_KALLSYMS you can send the dump
> >+   as is, otherwise you will have to use the "ksymoops" program to make
> >+   sense of the dump.  This utility can be downloaded from
>
> ksymoops is still useful even when CONFIG_KALLSYMS is on.  ksymoops
> decodes the Code: line, kallsyms does not.  Also kallsyms only handles
> code addresses[*], ksymoops handles all symbols.

Good point, i use ksymoops for Code: lines all the time, but in this
case the decoding can be done on the developer side instead of the bug
reporter. However your "handles code only" point still is very valid.
