Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267389AbSKPWm6>; Sat, 16 Nov 2002 17:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267390AbSKPWm6>; Sat, 16 Nov 2002 17:42:58 -0500
Received: from franka.aracnet.com ([216.99.193.44]:63967 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267389AbSKPWm6>; Sat, 16 Nov 2002 17:42:58 -0500
Date: Sat, 16 Nov 2002 14:47:04 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mehdi Hashemian <mhashemian@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: High Memory question
Message-ID: <555043050.1037458023@[10.10.2.3]>
In-Reply-To: <F101LYLFlELHRAAfbO50000e6bf@hotmail.com>
References: <F101LYLFlELHRAAfbO50000e6bf@hotmail.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Going through different parts of Kernel, I am trying to figure out if I need to change /page.h/__PAGE_OFFSET to some smaller value when compiling with CONFIG_HIGHMEM4G option to support more than 1G physical memory. 

No.

> Other than that, I can not figure out how virtual address for vmalloc and ioremap are going to fit above logical addresses.

By default it'll be the top 128Mb of RAM. Phys addrs are not mapped
1-1 onto virtual if you have highmem any more.

M.

