Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272541AbRH3XCe>; Thu, 30 Aug 2001 19:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272542AbRH3XCZ>; Thu, 30 Aug 2001 19:02:25 -0400
Received: from t2.redhat.com ([199.183.24.243]:41719 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S272541AbRH3XCS>; Thu, 30 Aug 2001 19:02:18 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200108302247.f7UMl4f31365@oboe.it.uc3m.es> 
In-Reply-To: <200108302247.f7UMl4f31365@oboe.it.uc3m.es> 
To: ptb@it.uc3m.es
Cc: "Herbert Rosmanith" <herp@wildsau.idv-edu.uni-linz.ac.at>,
        linux-kernel@vger.kernel.org, dhowells@cambridge.redhat.com
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 31 Aug 2001 00:02:05 +0100
Message-ID: <12803.999212525@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ptb@it.uc3m.es said:
>  Well, I understand what you mean, but if the linux kernel wants it
> and the C spec doesn't forbid it, then it'll either stay that way or
> an "official" way will be found of evoking the desired behaviour. 

In the world I've been living in for the last few years, GCC people don't
seem to take that much care to avoid breaking the kernel, especially when
the kernel is being gratuitously broken. David's __builtin_ct_assertion()
stuff looks like a sane way of getting the desired behaviour without having
to sacrifice any chickens, and getting that merged into GCC so that we can 
start to use it seems like a good idea.

>  OTOH I now can't get #__LINE__ to expand as I want it where I want
> it. 

Heh. That's magic.

--
dwmw2


