Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263393AbTIWUyE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 16:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263417AbTIWUyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 16:54:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:14750 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263393AbTIWUyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 16:54:03 -0400
Date: Tue, 23 Sep 2003 13:34:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Memory leak in mtd/chips/cfi_cmdset_0020.c
Message-Id: <20030923133432.6445cb28.akpm@osdl.org>
In-Reply-To: <3F709E0D.7090307@terra.com.br>
References: <3F709E0D.7090307@terra.com.br>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe W Damasio <felipewd@terra.com.br> wrote:
>
> 	This function is called by inter_module_register...so I'm not sure it 
> should really be freed...please review :)

Is fine, thanks.
