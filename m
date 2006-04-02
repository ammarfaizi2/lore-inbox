Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWDBK2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWDBK2S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 06:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWDBK2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 06:28:18 -0400
Received: from cantor.suse.de ([195.135.220.2]:19122 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932269AbWDBK2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 06:28:17 -0400
Date: Sun, 2 Apr 2006 12:28:15 +0200
From: Olaf Hering <olh@suse.de>
To: John Mylchreest <johnm@gentoo.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, paulus@samba.org
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060402102815.GA29717@suse.de>
References: <20060401224849.GH16917@getafix.willow.local> <20060402085850.GA28857@suse.de> <20060402102259.GM16917@getafix.willow.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060402102259.GM16917@getafix.willow.local>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Apr 02, John Mylchreest wrote:

>   BOOTLD  arch/powerpc/boot/zImage.vmode
>   arch/powerpc/boot/prom.o(.text+0x19c): In function `call_prom':
>   : undefined reference to `__stack_smash_handler'

Any this strange "security feature" is disabled by defining __KERNEL__?
