Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965182AbWEOTLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbWEOTLj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbWEOTLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:11:38 -0400
Received: from mx1.suse.de ([195.135.220.2]:61387 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965198AbWEOTLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:11:37 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] x86 NUMA panic compile error
Date: Mon, 15 May 2006 21:11:20 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, apw@shadowen.org,
       linux-kernel@vger.kernel.org
References: <20060515005637.00b54560.akpm@osdl.org> <200605152037.54242.ak@suse.de> <1147719901.6623.78.camel@localhost.localdomain>
In-Reply-To: <1147719901.6623.78.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152111.20693.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think you are right: there are very few end users running with
> CONFIG_NUMA on normal x86.  But, there is a disproportionately large
> number of developers who do it.  There are quite a few IBM (and maybe
> more via OSDL) developers who's only access to real NUMA hardware is x86
> NUMAQs and Summit machines.  When somebody says "foo is broken on NUMA",
> I go right to an x86 box.
> Anyway, I'd like to think that we've contributed enough to the generic
> NUMA code to have earned our keep and allow our little x86 NUMA "hacks"
> to remain.  

Yes that is why i did the "only work on Summit" patch as compromise.
With that you can have your hacks, but it won't impact anybody else.

> x86 is a legacy architecture now anyway, right? ;)
I wish everybody would agree on that @)

-Andi
