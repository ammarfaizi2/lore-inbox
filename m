Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265996AbUI0FP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUI0FP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 01:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUI0FP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 01:15:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:43451 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265996AbUI0FP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 01:15:27 -0400
Date: Sun, 26 Sep 2004 22:13:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4
Message-Id: <20040926221317.2e2d0be5.akpm@osdl.org>
In-Reply-To: <200409270053.22911.gene.heskett@verizon.net>
References: <20040926181021.2e1b3fe4.akpm@osdl.org>
	<200409270053.22911.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
>  The bootup hangs, from dmesg after reboot to 2.6.9-rc2-mm3:
> 
>  Checking 'hlt' instruction... OK.
>  -----
>  2.6.9-rc2-mm4 hangs here, and never gets to the next line
>  -----
>  NET: Registered protocol family 16
> 
>  So I assume something in the next line hangs it. Sysrq-t has no 
>  repsonse, must use the hardware reset button.

Try booting with `acpi=off'

Try reverting allow-multiple-inputs-in-alternative_input.patch
