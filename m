Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVBPT0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVBPT0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 14:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVBPT0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 14:26:37 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:21154 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261526AbVBPT0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 14:26:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=SlVKS8zGNc2ju7UiuNkrWsre99kxrC8wjPhrEKI0znlXKgMmuOSjbFJ+p9okB0VKuby/WwQjYFpjI6HIv9WoigvA9qcC3mBzrDEMWALqyYlqHrca528yn7vvT1vCNJf+pmG366Gc1pPOb7qqQImSRXOTiU4V7sathXSsdy7wxH4=
Message-ID: <451d804b050216112640f5c662@mail.gmail.com>
Date: Thu, 17 Feb 2005 00:56:31 +0530
From: shishir verma <shishir.lkml@gmail.com>
Reply-To: shishir verma <shishir.lkml@gmail.com>
To: Paulo Marques <pmarques@grupopie.com>
Subject: Re: strange bug with realtek 8169 card
Cc: Felipe W Damasio <felipewd@terra.com.br>,
       Francois Romieu <romieu@fr.zoreil.com>, a.hocquel@oreka.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <421396A4.2060009@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3xSPL-6F2-55@gated-at.bofh.it> <3y6g1-KN-23@gated-at.bofh.it>
	 <42138AA5.3040506@oreka.com>
	 <20050216181949.GA17159@electric-eye.fr.zoreil.com>
	 <42139203.3070903@terra.com.br> <421396A4.2060009@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

by any chance is the watchdog enabled for the card...because i had a
similar problem with a broadcom gigabit card....i commented the
watchdog code and made the module again...
it worked like a charm for me after that...
-shishir


On Wed, 16 Feb 2005 18:53:24 +0000, Paulo Marques <pmarques@grupopie.com> wrote:
> Felipe W Damasio wrote:
> >
> > Francois Romieu wrote:
> >
> >> Please try:
> >> http://www.fr.zoreil.com/~francois/misc/20050202-2.4.29-r8169.c-test.patch
> >
> >     404 Not Found
> 
> Try:
> 
> http://www.fr.zoreil.com/people/francois/misc/20050202-2.4.29-r8169.c-test.patch
> 
> --
> Paulo Marques - www.grupopie.com
> 
> All that is necessary for the triumph of evil is that good men do nothing.
> Edmund Burke (1729 - 1797)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
