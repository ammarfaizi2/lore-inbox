Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVIJQvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVIJQvR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 12:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbVIJQvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 12:51:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41391 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750789AbVIJQvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 12:51:17 -0400
Date: Sat, 10 Sep 2005 09:51:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Miguel <frankpoole@terra.es>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PCI bug in 2.6.13
In-Reply-To: <20050910113658.178a7711.frankpoole@terra.es>
Message-ID: <Pine.LNX.4.58.0509100949370.30958@g5.osdl.org>
References: <20050909180405.3e356c2a.frankpoole@terra.es>
 <20050909225956.42021440.akpm@osdl.org> <20050910113658.178a7711.frankpoole@terra.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Sep 2005, Miguel wrote:
>
> > Ugly.   I assume you're referring to this?
> > 
> > Ignore disabled ROM resources at setup
> 
> Yes, that is.

Can you show the differences in "/sbin/lspci -vvx" with and without that 
patch? It really makes no sense for so many reasons that it's not even 
funny.

Also, what disk controller is this happening on?

		Linus
