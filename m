Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265437AbSKOBLp>; Thu, 14 Nov 2002 20:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbSKOBLp>; Thu, 14 Nov 2002 20:11:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57356 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265437AbSKOBLp>;
	Thu, 14 Nov 2002 20:11:45 -0500
Message-ID: <3DD44B4E.3030102@pobox.com>
Date: Thu, 14 Nov 2002 20:18:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       rl@hellgate.ch, linux-kernel@vger.kernel.org,
       Mikael Pettersson <mikpe@csd.uu.se>, mingo@redhat.com
Subject: Re: Yet another IO-APIC problem (was Re: via-rhine weirdness with
  viakt8235 Southbridge)
References: <20021115002822.G6981@pc9391.uni-regensburg.de> <20021115011738.D17058@pc9391.uni-regensburg.de> <3DD445EF.9080002@pobox.com> <3DD4481F.72627800@digeo.com>
In-Reply-To: <20021115002822.G6981@pc9391.uni-regensburg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Jeff Garzik wrote:
>
> >...
> >IMO we should just take out UP IOAPIC support in the kernel, or put a
> >big fat warning in the kernel config _and_ at boot...
> >
>
>
> It would be nice to get it working, because oprofile needs it.
>
> (Well, oprofile can use the rtc, but then it doesn't profile
> ints-off code)



I don't see it happening, when uniprocessor mobo vendors (a) don't wire 
it up, or (b) put buggy data in their MP tables...   :(

	Jeff



