Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277134AbRJHVKV>; Mon, 8 Oct 2001 17:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277135AbRJHVKJ>; Mon, 8 Oct 2001 17:10:09 -0400
Received: from node181b.a2000.nl ([62.108.24.27]:19973 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S277134AbRJHVKE>;
	Mon, 8 Oct 2001 17:10:04 -0400
Date: Mon, 8 Oct 2001 23:10:59 +0200 (CEST)
From: raid@ddx.a2000.nu
To: linux-kernel@vger.kernel.org
cc: linux-raid@vger.kernel.org
Subject: Re: write/read cache raid5
In-Reply-To: <E15qh8U-0001o8-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0110082309400.28345-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001, Alan Cox wrote:

> > With current memory prices i think about buying 2gb memory for my
> > fileserver (6*80gb raid5 ide)
> > Now i would like to use this memory for diskcache (write cache?)
> > Are there any things i can change to the kernel/samba to speedup things ?
>
> Linux will use free memory as caches. The one limitation you have is that
> it can't use it for write caching that much because the memory isnt
> protected, battery backed, ECC'd etc. That is one place where things like
> the DPT (now Adaptec) millenium hardware raid can do a lot better than
> software solutions

So there is no way i can Speedup write to the raid5 array ?
(memory will be ecc and the server will be on ups)

