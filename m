Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270323AbUJTOGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270323AbUJTOGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270364AbUJTOBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:01:46 -0400
Received: from A.painless.aaisp.net.uk ([81.187.81.51]:15752 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S270126AbUJTN42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 09:56:28 -0400
Message-ID: <4176725F.1000206@rgadsdon2.giointernet.co.uk>
Date: Wed, 20 Oct 2004 15:12:47 +0100
From: Robert Gadsdon <robert@rgadsdon2.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.8a2) Gecko/20040604
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: Robert Gadsdon <robert@rgadsdon2.giointernet.co.uk>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-bk3 - compile error
References: <4176537A.6070301@rgadsdon2.giointernet.co.uk>
In-Reply-To: <4176537A.6070301@rgadsdon2.giointernet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same with 2.6.9-bk4..

Robert Gadsdon wrote:
> ..............
> GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0xb8658): In function `i2o_pci_interrupt':
> : undefined reference to `i2o_msg_out_to_virt'
> drivers/built-in.o(.text+0xb8efa): In function `i2o_exec_reply':
> : undefined reference to `i2o_msg_in_to_virt'
> make: *** [.tmp_vmlinux1] Error 1
> 
