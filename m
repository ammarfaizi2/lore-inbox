Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWGGVrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWGGVrE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWGGVrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:47:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31895 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751259AbWGGVrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:47:02 -0400
Date: Fri, 7 Jul 2006 14:50:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       tyler@agat.net
Subject: Re: [PATCH 1/19] UML - Clean up address space limits code
Message-Id: <20060707145023.2edfd763.akpm@osdl.org>
In-Reply-To: <200607070033.k670XXqc008662@ccure.user-mode-linux.org>
References: <200607070033.k670XXqc008662@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> I was looking at the code of the UML and more precisely at the functions
> set_task_sizes_tt and set_task_sizes_skas. I noticed that these 2
> functions take a paramater (arg) which is not used : the function is
> always called with the value 0.
> 
> I suppose that this value might change in the future (or even can be
> configured), so I added a constant in mem_user.h file.
> 
> Also, I rounded CONFIG_HOST_TASk_SIZE to a 4M.
> 
> Signed-off-by: Tyler <tyler@agat.net>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>

I'll assume this patch was authored by Tyler <tyler@agat.net>

Please use a "From: " line right at the start of the email/changelog to indicate
authorship, thanks.

