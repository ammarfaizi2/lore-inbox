Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267053AbUBEXbt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267070AbUBEXbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:31:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:20125 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267053AbUBEXbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:31:47 -0500
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat" DIO read race still fails
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20040205014405.5a2cf529.akpm@osdl.org>
References: <20040205014405.5a2cf529.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1076023899.7182.97.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Feb 2004 15:31:39 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I tested 2.6.2-mm1 on an 8-proc running 6 copies of the read_under
test and all 6 read_under tests saw uninitialized data in less than 5
minutes. :(

Daniel



On Thu, 2004-02-05 at 01:44, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2/2.6.2-mm1/

> 
> O_DIRECT-ll_rw_block-vs-block_write_full_page-fix.patch
>   Fix race between ll_rw_block() and block_write_full_page()
> 


