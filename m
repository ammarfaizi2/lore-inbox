Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268685AbTGOQIj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268736AbTGOQHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:07:47 -0400
Received: from main.gmane.org ([80.91.224.249]:11656 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268685AbTGOQHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:07:20 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: nick black <dank@suburbanjihad.net>
Subject: Re: 2.6.0-test1-ac1 Matrox Compile Error
Date: Tue, 15 Jul 2003 16:16:38 +0000 (UTC)
Message-ID: <bf19d5$d00$1@main.gmane.org>
References: <1058285021.2209.13.camel@beowulf.cryptocomm.com>
Reply-To: dank@reflexsecurity.com
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1058285021.2209.13.camel@beowulf.cryptocomm.com>, Adam Voigt wrote:
> Let me know if I'm being stupid, but here's the error I get,
> and my .config is below:
> 
> 
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x66e7a): In function `matroxfb_set_par':
>: undefined reference to `default_grn'
> drivers/built-in.o(.text+0x66e7f): In function `matroxfb_set_par':
>: undefined reference to `default_blu'
> drivers/built-in.o(.text+0x66e93): In function `matroxfb_set_par':
>: undefined reference to `color_table'
> drivers/built-in.o(.text+0x66e9b): In function `matroxfb_set_par':
>: undefined reference to `default_red'
> make: *** [.tmp_vmlinux1] Error 1

you'll need to build VT support.

-- 
nick black <dank@reflexsecurity.com>
"np:  nondeterministic polynomial-time
the class of dashed hopes and idle dreams." - the complexity zoo

