Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271890AbRIDQGC>; Tue, 4 Sep 2001 12:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271982AbRIDQFx>; Tue, 4 Sep 2001 12:05:53 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:49426 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271890AbRIDQFh>; Tue, 4 Sep 2001 12:05:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Martin =?iso-8859-1?q?MOKREJ=3F=20?= <mmokrejs@natur.cuni.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 0-order allocation failed.
Date: Tue, 4 Sep 2001 18:12:40 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.OSF.4.21.0109041500460.8354-100000@prfdec.natur.cuni.cz>
In-Reply-To: <Pine.OSF.4.21.0109041500460.8354-100000@prfdec.natur.cuni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010904160546Z16284-32383+3441@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 4, 2001 03:11 pm, Martin MOKREJ? wrote:
> Hi,
>   I'm getting the above error on 2.4.9 kernel with kernel HIGHMEM option
> enabled to 2GB, 2x Intel PentiumIII. The machine has 1GB RAM
> physically. Althougj I've found many report to linux-kernel list during
> past months, not a real solution. Maybe only:
> http://www.alsa-project.org/archive/alsa-devel/msg08629.html

Try 2.4.10-pre4.

>   I hope it's not related to memory chunks allocated twice,

It's not

> so I think it's another problem in 2.4.9, right?

Yep.  Most probably bounce buffers, patch by Marcelo already in Linus's
tree.

--
Daniel
