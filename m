Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVCNKas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVCNKas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 05:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVCNKar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 05:30:47 -0500
Received: from extgw-uk.mips.com ([62.254.210.129]:5149 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S262108AbVCNKaj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 05:30:39 -0500
Date: Sat, 12 Mar 2005 21:12:49 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport kmap_{pte,port} on !ppc
Message-ID: <20050312211249.GB13454@linux-mips.org>
References: <20050311181645.GL3723@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311181645.GL3723@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 07:16:45PM +0100, Adrian Bunk wrote:

> I haven't found any modular usage of kmap_{pte,port} on !ppc in the 
> kernel.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 21 Jan 2005
> 
>  arch/i386/mm/init.c  |    3 ---
>  arch/mips/mm/init.c  |    3 ---

Looks good.

  Ralf
