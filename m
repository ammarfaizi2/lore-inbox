Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318974AbSHSSb6>; Mon, 19 Aug 2002 14:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318975AbSHSSb6>; Mon, 19 Aug 2002 14:31:58 -0400
Received: from mail.zmailer.org ([62.240.94.4]:32447 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S318974AbSHSSbz>;
	Mon, 19 Aug 2002 14:31:55 -0400
Date: Mon, 19 Aug 2002 21:35:57 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Xuehua Chen <namniardniw@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A question about cache coherence
Message-ID: <20020819183557.GU32427@mea-ext.zmailer.org>
References: <20020819182121.93059.qmail@web13008.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020819182121.93059.qmail@web13008.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 11:21:21AM -0700, Xuehua Chen wrote:
> Met a problem in my research. I run some code on a
> Xeon dual-processor machine. It seems to me that there is
> a cache coherence problem. As I am not so familiar 
> to this topic, I would like to ask some experts about 
> the following questions.
> 
> 1. Do Xeon processors have hardware mechanisms to
>    maintain cache coherence?

   Yes, in usual closely coupled SMP systems.

> 2. Does the SMP kernel handle the cache coherence
>     problem

   In its own ways, yes.  It is relying on hardware doing
   it in major part.

> 3. What should I do if both of them don't handle cache
>    coherence.

   Report the issue with lots of technical details
   on  linux-smp@vger.kernel.org,  and possibly continue
   discussion there.

   Data like:
    - What machine, whose motherboard ?
    - How much memory ?
    - What steppings are the processors ?  (not same ?)
    - How you configured the kernel ?
       (Not quite the entire  .config  file, just first
        50 lines or so telling processor details.)

   And most importantly:
    - Describe why do you suspect there is cache-coherence
      problem in the system ?   In the kernel side, or
      in your application ?   How it is manifesting itself ?


> Thanks.
> Frank Samuel

/Matti Aarnio
