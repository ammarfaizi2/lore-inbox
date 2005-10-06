Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbVJFOCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbVJFOCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbVJFOCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:02:16 -0400
Received: from mx1.suse.de ([195.135.220.2]:63649 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751001AbVJFOCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:02:16 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: SMP syncronization on AMD processors (broken?)
Date: Thu, 6 Oct 2005 15:56:30 +0200
User-Agent: KMail/1.8.2
Cc: Eric Dumazet <dada1@cosmosbay.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, xemul@sw.ru,
       Andrey Savochkin <saw@sawoct.com>, st@sw.ru
References: <434520FF.8050100@sw.ru> <p73hdbuzs7l.fsf@verdi.suse.de> <43452BAC.3000306@cosmosbay.com>
In-Reply-To: <43452BAC.3000306@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510061556.31305.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 October 2005 15:50, Eric Dumazet wrote:

> Maybe we should reflect this in Kconfig ?
>
> config NR_CPUS
> range 2 128
>
> Or use a plain int for spinlock, instead of a signed char.

Hmm? 2.6 already uses int as far as I can see.

-Andi
