Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbWGFRag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWGFRag (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWGFRag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:30:36 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:55422 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030315AbWGFRag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:30:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ZIQrlTX24QMZl9+HtWRBUktUjgKQmc4RCxVFZ6k5fwoKnoGSXLwPu706fUPz51XOveisBTreDdzTn3bnq9FpJs3Y55UZy17ALcPuRGzzcsUl1n+9xS5zQiB4d7CthzZT/TTOuSS4H2d4y/Seq7VrdEjhX5X7fuL4MXkVn1DDMeI=  ;
Message-ID: <44AD3D03.8080507@yahoo.com.au>
Date: Fri, 07 Jul 2006 02:40:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com> <1152187268.3084.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0607060816110.8320@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0607060816110.8320@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:

>  	http://en.wikipedia.org/wiki/Memory_barrier
> 
> This is used to prevent out-of-order execution, not at all what is
> necessary.

I don't think memory barriers prevent out of order execution,
just out of order loads and stores (which could happen on CPUs
that do in-order execution).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
