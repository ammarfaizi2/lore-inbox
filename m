Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWGJKhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWGJKhJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWGJKhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:37:08 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:51559 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751301AbWGJKhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:37:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hlRtUCheGjOiHqFQYYihF6iVCvxljmg91ZRPsqgSz4HpAcjwUKt2vbbLNdubnEH77MNin9W5/NxoklY+P5qXowFmvn/lx0TBwDOUGrICkggWbnNilwAE0yiHqpq5dVyqJxM+TdOaQoWXF6AGkaBYNmy2HtSRjoRFlrzN4ePdq/4=
Message-ID: <6bffcb0e0607100337v41cb807eta26a2aa370e582ff@mail.gmail.com>
Date: Mon, 10 Jul 2006 12:37:05 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.18-rc1-mm1
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <6bffcb0e0607100301j1fa444au2c3ecd7128e126ef@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> On 10/07/06, Ingo Molnar <mingo@elte.hu> wrote:
> > ah, ok. So i'll put this under the 'unclean-build artifact' section,
> > i.e. not a lockdep bug for now, it seems. Please re-report if it ever
> > occurs again with a clean kernel build.
>
> Unfortunately "make O=/dir clean" doesn't help. I'll disable lockdep,
> and see what happens.
>

When I set DEBUG_LOCK_ALLOC=n and CONFIG_PROVE_LOCKING=n everything is ok.
It maybe a gcc 4.2 bug.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
