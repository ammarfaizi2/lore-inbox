Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270581AbRHIUiN>; Thu, 9 Aug 2001 16:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270583AbRHIUiD>; Thu, 9 Aug 2001 16:38:03 -0400
Received: from quattro.sventech.com ([205.252.248.110]:57872 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S270581AbRHIUhr>; Thu, 9 Aug 2001 16:37:47 -0400
Date: Thu, 9 Aug 2001 16:35:32 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: struct page to 36 (or 64) bit bus address?
Message-ID: <20010809163531.D1575@sventech.com>
In-Reply-To: <20010809151022.C1575@sventech.com> <E15UvLO-0007tH-00@the-village.bc.nu> <15218.61869.424038.30544@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <15218.61869.424038.30544@pizda.ninka.net>; from davem@redhat.com on Thu, Aug 09, 2001 at 01:25:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001, David S. Miller <davem@redhat.com> wrote:
> 
> Alan Cox writes:
>  > > Obviously the more portable way across architectures is using the PCI
>  > > DMA API but when will the implementation be fixed so I can use it to
>  > > exploit the full potential of this device?
>  > 
>  > 2.5 I believe, ping the peacefrog and ask <DaveM@redhat.com>
> 
> That's the current plan.  There may be a 2.4.x backport, but no
> promises.  It all depends upon how straightforward the changes
> are.

It's not a big deal. It's just less efficient which isn't the end of the
world.

> Note, if you use the "bttv method" (ie. virt_to_bus) your driver will
> then fail to compile on several platforms.

So noted. I already have a PCI DMA API version, but I wanted to code up
a "i have an i386 and gigs of memory" version as well.

JE

