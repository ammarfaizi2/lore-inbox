Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274164AbRIXUyB>; Mon, 24 Sep 2001 16:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274167AbRIXUxw>; Mon, 24 Sep 2001 16:53:52 -0400
Received: from t2.redhat.com ([199.183.24.243]:241 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S274164AbRIXUxj>; Mon, 24 Sep 2001 16:53:39 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.30.0109242233150.18098-100000@Appserv.suse.de> 
In-Reply-To: <Pine.LNX.4.30.0109242233150.18098-100000@Appserv.suse.de> 
To: Dave Jones <davej@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compilation fix for nand.c 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 24 Sep 2001 21:54:02 +0100
Message-ID: <30460.1001364842@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davej@suse.de said:
>  nand.c uses do_softirq() without including interrupt.h. Patch below
> makes things compile again.

Fixed in ftp.uk.linux.org:/pub/people/dwmw2/mtd/mtd-diff-against-2.4.10-v4

I haven't finished reading through that and taking compatibility cruft out 
yet, but I expect to have it split up and sent to Linus some time this week.

--
dwmw2


