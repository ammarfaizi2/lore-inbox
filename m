Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272471AbRH3VQG>; Thu, 30 Aug 2001 17:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272477AbRH3VPv>; Thu, 30 Aug 2001 17:15:51 -0400
Received: from t2.redhat.com ([199.183.24.243]:56822 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S272471AbRH3VPQ>; Thu, 30 Aug 2001 17:15:16 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200108302106.f7UL6t917787@oboe.it.uc3m.es> 
In-Reply-To: <200108302106.f7UL6t917787@oboe.it.uc3m.es> 
To: ptb@it.uc3m.es
Cc: "Herbert Rosmanith" <herp@wildsau.idv-edu.uni-linz.ac.at>,
        linux-kernel@vger.kernel.org, dhowells@cambridge.redhat.com
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 30 Aug 2001 22:14:56 +0100
Message-ID: <10868.999206096@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ptb@it.uc3m.es said:
>  And I was hoping that somebody could produce some gcc magic
> replacement for BUG() that means "don't compile me". Perhaps a bit of
> illegal assembler code with a line reference in? Surely gcc must have
> something like __builtin_wont_compile()? It just needs to be a leaf of
> the RTL that evokes a compile error.

It's done. I believe it was called __builtin_ct_assertion(). I don't think 
it got merged (yet?).


--
dwmw2


