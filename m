Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274149AbRISTuz>; Wed, 19 Sep 2001 15:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274150AbRISTup>; Wed, 19 Sep 2001 15:50:45 -0400
Received: from [209.202.108.240] ([209.202.108.240]:61703 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S274149AbRISTuh>; Wed, 19 Sep 2001 15:50:37 -0400
Date: Wed, 19 Sep 2001 15:50:45 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <3BA8EA04.E55BAA02@redhat.com>
Message-ID: <Pine.LNX.4.33.0109191548080.29593-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Arjan van de Ven wrote:

> Ok but that part is simple:
>
> run
>
> http://www.fenrus.demon.nl/athlon.c

>From an Athlon 1050/KT133 (middle 3 of 5):

Clear:
warm up run: 16653.33
2.4 non MMX: 10803.33
2.4 MMX fallback: 10576.67
2.4 MMX version: 9824.33
faster_copy: 4416.67
even_faster: 4316.67

Copy:
warm up run: 15268.33
2.4 non MMX: 23765.33
2.4 MMX fallback: 23629.33
2.4 MMX version: 15316.67
faster_copy: 9352.00
even_faster: 9333.33

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>


