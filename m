Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281185AbRKLX2i>; Mon, 12 Nov 2001 18:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281189AbRKLX23>; Mon, 12 Nov 2001 18:28:29 -0500
Received: from user-119a3cr.biz.mindspring.com ([66.149.13.155]:21765 "HELO
	fancypants.trellisinc.com") by vger.kernel.org with SMTP
	id <S281185AbRKLX2O>; Mon, 12 Nov 2001 18:28:14 -0500
Date: Mon, 12 Nov 2001 18:28:11 -0500
From: Jason Lunz <j@trellisinc.com>
To: Frank de Lange <lkml-frank@unternet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Abysmal interactive performance on 2.4.linus
Message-ID: <20011112182811.A5412@trellisinc.com>
In-Reply-To: <20011112205551.A14132@unternet.org> <3BF02BA4.D7E2D70E@mandrakesoft.com> <3BF02BA4.D7E2D70E@mandrakesoft.com> <20011112235642.A17544@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011112235642.A17544@unternet.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In mlist.linux-kernel, you wrote:
> Seems that reiserfs is the common factor here, at least on my box. This is a 35
> GB reiserfs filesystem, app 80% used, both large and small files.
> 
> As said in my previous message, the numbers themselves don't mean squat. It is
> the large delays (the fact that user+sys <<< real) which are the problem here.

As another data point, I'm seeing the exact same thing. I haven't tried
any non-Linus kernels, though. But recent 2.4.x (x >= 10?) linus kernels
with reiserfs have these several-second delays during moderate-to-heavy
disk i/o, exactly as you've described. I've seen this on both an SMP
PIII system and a UP Athlon.

-- 
Jason Lunz		Trellis Network Security
j@trellisinc.com	http://www.trellisinc.com/
