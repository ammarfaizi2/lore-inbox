Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWKBReL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWKBReL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWKBReL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:34:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:38097 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750919AbWKBReK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:34:10 -0500
From: Andi Kleen <ak@suse.de>
To: "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: [PATCH] SA_SIGINFO was forgotten
Date: Thu, 2 Nov 2006 18:34:10 +0100
User-Agent: KMail/1.9.5
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Linus Torvalds" <torvalds@osdl.org>
References: <787b0d920610311009i17b4101cg85229603df64880e@mail.gmail.com>
In-Reply-To: <787b0d920610311009i17b4101cg85229603df64880e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611021834.10907.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> +       /* Make -mregparm=3 work */
> +       regs->rax = sig;
> +       regs->rdx = (unsigned long) &frame->info;
> +       regs->rcx = (unsigned long) &frame->uc;

Applied, but please use tabs instead of spaces to indent next time.

Thanks.

-Andi

