Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbULGTSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbULGTSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 14:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbULGTSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 14:18:15 -0500
Received: from mail.dif.dk ([193.138.115.101]:59306 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261886AbULGTSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 14:18:11 -0500
Date: Tue, 7 Dec 2004 20:28:19 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: katrina@fortifysoftware.com
Cc: Katrina Tsipenyuk <ytsipenyuk@fortifysoftware.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: unchecked returns from kmalloc() in linux-2.6.10-rc2
In-Reply-To: <1102443607.3748.6.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0412072024080.3378@dragon.hygekrogen.localhost>
References: <1102443607.3748.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2004, Katrina Tsipenyuk wrote:

> Linux developers,
>                                                                                                                                                              
> We -- Fortify Software engineering team -- have looked at
> linux-2.6.10-rc2 and performed static analysis of the code. 
> We have discovered several instances of the same potential 
> vulnerability in the kernel code. 
[...]
> [1.] We have found several instances of unchecked return values from
> kmalloc().
[...]


Unless someone else beats me to it I'll take a stab at fixing these.
Thank you for the report. Expect patches shortly (hopefully :)

-- 
Jesper Juhl <juhl-lkml@dif.dk>

