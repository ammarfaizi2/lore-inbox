Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbUKKLBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbUKKLBo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 06:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbUKKLBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 06:01:44 -0500
Received: from [217.222.53.238] ([217.222.53.238]:9369 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S262151AbUKKLBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 06:01:43 -0500
Message-ID: <41934638.30408@gts.it>
Date: Thu, 11 Nov 2004 12:00:08 +0100
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brice.Goglin@ens-lyon.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5
References: <20041111012333.1b529478.akpm@osdl.org> <419342D9.6060009@ens-lyon.fr>
In-Reply-To: <419342D9.6060009@ens-lyon.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin wrote:

> Hi Andrew,
> 
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x1c5a4): In function `fbcon_set_font':
> : undefined reference to `crc32_le'
> make: *** [.tmp_vmlinux1] Erreur 1

I had this too, resolved by compiling CRC32 built in and not as a module.

-- 
Stefano RIVOIR

