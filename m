Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272213AbRH3NSH>; Thu, 30 Aug 2001 09:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272200AbRH3NR6>; Thu, 30 Aug 2001 09:17:58 -0400
Received: from t2.redhat.com ([199.183.24.243]:28402 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S272215AbRH3NRn>; Thu, 30 Aug 2001 09:17:43 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200108301310.f7UDAXx05887@buggy.badula.org> 
In-Reply-To: <200108301310.f7UDAXx05887@buggy.badula.org> 
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 30 Aug 2001 14:17:22 +0100
Message-ID: <19468.999177442@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ionut@cs.columbia.edu said:
> ... unless of course the programmer used an unsigned char when what he
>  really wanted was a signed char. But in that case even your typed min
>  macro won't save him, because what should the forced type be anyway?
> If  it's "int", nothing changes; if it's "signed char", you risk
> truncating  the int. So you end up with something like

> 	min(int, a, (char)b) 

If the programmer wrote that when he really wanted a signed char, he has 
more fundamental brokenness to worry about than the min/max fun.

--
dwmw2


