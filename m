Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbUCADXq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 22:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbUCADXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 22:23:46 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:42011 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262229AbUCADXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 22:23:45 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6] linux/README update 
In-reply-to: Your message of "Fri, 27 Feb 2004 08:18:20 CDT."
             <Pine.LNX.4.58.0402270815350.17504@montezuma.fsmlabs.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Mar 2004 14:23:01 +1100
Message-ID: <3596.1078111381@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 08:18:20 -0500 (EST), 
Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>- - You can use the "ksymoops" program to make sense of the dump.  This
>-   utility can be downloaded from
>+ - If you compiled the kernel with CONFIG_KALLSYMS you can send the dump
>+   as is, otherwise you will have to use the "ksymoops" program to make
>+   sense of the dump.  This utility can be downloaded from

ksymoops is still useful even when CONFIG_KALLSYMS is on.  ksymoops
decodes the Code: line, kallsyms does not.  Also kallsyms only handles
code addresses[*], ksymoops handles all symbols.

[*] Rusty's definition of "all symbols" does not not match mine.
    kallsyms in 2.6 should really be "ksomesyms".

