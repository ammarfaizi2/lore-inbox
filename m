Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbTL3Xgd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 18:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265820AbTL3Xgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 18:36:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41403 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265817AbTL3Xgb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 18:36:31 -0500
Message-ID: <3FF20BEB.4090100@pobox.com>
Date: Tue, 30 Dec 2003 18:36:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willem <wdit@xs4all.nl>
CC: linux-kernel@vger.kernel.org, matic@cyberia.net.lb, slaugther@linux.nu
Subject: Re: Patch (fix for libata patch 2.6.0-1) in ata_std_bio_param
References: <200312310024.08393.wdit@xs4all.nl>
In-Reply-To: <200312310024.08393.wdit@xs4all.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willem wrote:
> I got the following problem when compiling linux 2.6.0 + 2.6.0libata1 patch. 
> (On a recent Intel motherboard with SATA, so I applied the libata patch.) 
> 
> Since I noticed this problem at the Gentoo bugs site as well 
> ( http://bugs.gentoo.org/show_bug.cgi?id=36812 )
> I decided to publish this patch, to help others. 
> 
>  LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0xa7784): In function `ata_std_bios_param':
> : undefined reference to `__udivdi3'
> make: *** [.tmp_vmlinux1] Error 1
> * gen_die(): Could not copy kernel binary to boot
> 
> The following patch fixes this. 
> Best regards, and happy 2004!


Linus fixed this for us :)  Grab 2.6.0-bk3...

	Jeff



