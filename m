Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286297AbRLTRIm>; Thu, 20 Dec 2001 12:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286298AbRLTRIW>; Thu, 20 Dec 2001 12:08:22 -0500
Received: from colorfullife.com ([216.156.138.34]:59657 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S286297AbRLTRIU>;
	Thu, 20 Dec 2001 12:08:20 -0500
Message-ID: <3C221B09.4090201@colorfullife.com>
Date: Thu, 20 Dec 2001 18:08:25 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] improve spinlock debugging
In-Reply-To: <3C0BDC33.6E18C815@colorfullife.com> <20011219025332.GA18344@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:

>
>What do you think of the idea below? We create arch specific spinlock
>functions as __foo and wrap the debugging bits around them as foo. This
>should also allow us to unify the UP and SMP spinlock debugging somewhat.
>
I tried to create a minimal patch, to reduce the probability of patch 
conflicts with earlier/future kernels.

I agree that your solutition is better if the patch is included in 
Linus/Marcelo's tree.
Have you asked Linus about it? I love runtime checks, but IIRC the 
majority of the kernel maintainers disagrees.

--
    Manfred

