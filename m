Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270014AbRHQJFa>; Fri, 17 Aug 2001 05:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270001AbRHQJFW>; Fri, 17 Aug 2001 05:05:22 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:27040 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S270020AbRHQJFG>;
	Fri, 17 Aug 2001 05:05:06 -0400
Date: Fri, 17 Aug 2001 11:05:07 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Optionally let Net Devices feed Entropy
Message-ID: <20010817110507.A25342@se1.cogenit.fr>
In-Reply-To: <997936615.921.22.camel@phantasy> <20010816105010.A10595@se1.cogenit.fr> <997973433.684.3.camel@phantasy> <20010816190255.A17095@se1.cogenit.fr> <998009276.660.69.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <998009276.660.69.camel@phantasy>; from rml@tech9.net on Thu, Aug 16, 2001 at 08:47:48PM -0400
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> :
[...]
> making it configurable.  Nothing is experimental.  This does not change
> things; it makes things configurable.

I have checked again the patches and they allow a lot of drivers to feed 
the entropy pool that otherwise wouldn't had ever contributed to it. Thus 
it changes things and opens the question about the effects on entropy 
estimate. See the figures, three (3) nics to date reference SA_SAMPLE_RANDOM.
As the fact that 2.4 is supposed to be a stable serie, I assume it's
irrelevant.

-- 
Ueimor
