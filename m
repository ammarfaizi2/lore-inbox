Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132744AbRDDOY1>; Wed, 4 Apr 2001 10:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132734AbRDDOYR>; Wed, 4 Apr 2001 10:24:17 -0400
Received: from [193.120.224.170] ([193.120.224.170]:38801 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S132700AbRDDOYH>;
	Wed, 4 Apr 2001 10:24:07 -0400
Date: Wed, 4 Apr 2001 15:20:04 +0100 (IST)
From: Paul Jakma <paulj@itg.ie>
To: christophe barbe <christophe.barbe@lineo.fr>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: uninteruptable sleep (D state => load_avrg++)
In-Reply-To: <20010404141349.A6702@pc8.inup.com>
Message-ID: <Pine.LNX.4.33.0104041518300.1150-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2001, christophe barbe wrote:

> The sleep should certainly be interruptible and I that's what I
> said to the GFS guy. But what the reason to increment the load
> average for each D process ?

from a philosical POV: they are processes that will be runnable as
soon as the kernel returns to them.

no idea if there are technical reasons for it.

>
> Thanks,
> Christophe

--paulj

