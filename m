Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWKDG2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWKDG2N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 01:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWKDG2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 01:28:13 -0500
Received: from main.gmane.org ([80.91.229.2]:54938 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932426AbWKDG2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 01:28:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: Simple module for 2.6 request?
Date: Sat, 4 Nov 2006 06:27:54 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnekod4d.2j9.olecom@flower.upol.cz>
References: <454C1F84.9010601@limcore.pl>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> it is not so easy to find online an *working* example of how to by hand
> build a module.

Please find information on how to build (external) modules in
"Documentation/kbuild/modules.txt" directory of your linux source tree.
More (implementation) info can be found in the top Makefile.

> gcc -o foo.c -ko foo.ko -DMODULE -D__KERNEL__
> -I/usr/src/kernel-headers-directory/include/
>
> with module license define macro
>
> almost worked, but it misses thoes extra symbols created in
> post-compilation.
>
> How to add them by hand (not using all the big Makefiles normally
> included in kernel tree)?
>
> Like
> some-command foo.ko foo.c
> insmod foo.ko
> done
____

