Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWGJK6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWGJK6D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWGJK6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:58:01 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:17553 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964792AbWGJK6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:58:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eHadUxU4iwk3qJGvqqM35iTM1XnezK9stw0e53T4flQeVxkTb6RYKRL9Za9ySUugq2GLciVpRLRCLyD4KKOebvXPUXriaBpvgkV8JF06/++0xV3X2fFy3le/IZW2wTx1ZL+L44U1L5PXOEHr+1vFVQNb6yKCa87MYnESEqsHdH8=
Message-ID: <6bffcb0e0607100357q7762cd7dw757626e4cc680900@mail.gmail.com>
Date: Mon, 10 Jul 2006 12:57:58 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.18-rc1-mm1
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <20060710103724.GA10602@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060709021106.9310d4d1.akpm@osdl.org>
	 <6bffcb0e0607090332i477d594fq9ef96721574ae91b@mail.gmail.com>
	 <20060709035203.cdc3926f.akpm@osdl.org>
	 <20060710074039.GA26853@elte.hu>
	 <6bffcb0e0607100222m5cbdba31ia39d47f3f1f94b26@mail.gmail.com>
	 <20060710092528.GA8455@elte.hu>
	 <6bffcb0e0607100301j1fa444au2c3ecd7128e126ef@mail.gmail.com>
	 <6bffcb0e0607100337v41cb807eta26a2aa370e582ff@mail.gmail.com>
	 <20060710103724.GA10602@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> > On 10/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > >On 10/07/06, Ingo Molnar <mingo@elte.hu> wrote:
> > >> ah, ok. So i'll put this under the 'unclean-build artifact' section,
> > >> i.e. not a lockdep bug for now, it seems. Please re-report if it ever
> > >> occurs again with a clean kernel build.
> > >
> > >Unfortunately "make O=/dir clean" doesn't help. I'll disable lockdep,
> > >and see what happens.
> > >
> >
> > When I set DEBUG_LOCK_ALLOC=n and CONFIG_PROVE_LOCKING=n everything is
> > ok. It maybe a gcc 4.2 bug.

It's not gcc 4.2 bug.

>
> well ... if you disable lockdep then you wont get lockdep messages -
> that's normal.

I'm just checking ;).

> Or did i miss what the bug is about?
>
>         Ingo
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
