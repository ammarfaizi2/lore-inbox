Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWF1QHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWF1QHF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWF1QHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:07:05 -0400
Received: from xenotime.net ([66.160.160.81]:16569 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751326AbWF1QHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:07:04 -0400
Date: Wed, 28 Jun 2006 09:09:50 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Lukas Jelinek <info@kernel-api.org>
Cc: ptesarik@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Kernel API Reference Documentation
Message-Id: <20060628090950.c1862a9e.rdunlap@xenotime.net>
In-Reply-To: <44A2749D.7030705@kernel-api.org>
References: <44A1858B.9080102@kernel-api.org>
	<1151495225.8127.68.camel@elijah.suse.cz>
	<44A2749D.7030705@kernel-api.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 14:22:53 +0200 Lukas Jelinek wrote:

> > 
> > I looked at
> > http://www.kernel-api.org/docs/online/2.6.17/da/dab/structsk__buff.html
> > 
> > and you apparently ignore kernel-doc for structs. Cf.
> > include/linux/skbuff.h:177 ff.
> > 
> > Regards,
> > Petr Tesarik
> > 
> 
> There are several problems. The one you describe is probably caused by a
> blank line between the struct and the related comment. Doxygen doesn't
> recognize it correctly (and simply ignores the comment).

No blank line in this case.

And since you read the kernel-doc HOWTO, you now know that
struct, enum, and typedef may have kernel-doc notations, right?

Thanks,
---
~Randy
