Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319022AbSHFJDA>; Tue, 6 Aug 2002 05:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319023AbSHFJDA>; Tue, 6 Aug 2002 05:03:00 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:62409 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S319022AbSHFJC7>; Tue, 6 Aug 2002 05:02:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: arnd@bergmann-dalldorf.de
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] 15/18 better pte invalidation
Date: Tue, 6 Aug 2002 13:05:17 +0200
User-Agent: KMail/1.4.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>
References: <200208051830.50713.arndb@de.ibm.com> <200208051954.55546.arndb@de.ibm.com> <20020805180103.A16035@infradead.org>
In-Reply-To: <20020805180103.A16035@infradead.org>
Organization: IBM Deutschland Entwicklung GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208061305.17296.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 August 2002 19:01, Christoph Hellwig wrote:
> Implementation comment: make pgd_populate return something on all
> architectures, not just on s390.
Makes sense to me. Martin?

> Otherwise please try to get all this in 2.5 first, it's a major VM change.
Right. I guess this one falls more in the category "If anyone wants to build
an s390 2.4.19 kernel, use this patch, because it's what we have tested at 
IBM".

Since the 18 patches reflect what our recommended 2.4.17 patch contains 
(roughly sorted by relevance), not all of it is necessarily good for 2.4.20.
You can see it as "this is all we have -- take what you like". Of course,
anything that gets merged makes life easier for us.

	Arnd <><
