Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270584AbRHIU0n>; Thu, 9 Aug 2001 16:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270581AbRHIU0d>; Thu, 9 Aug 2001 16:26:33 -0400
Received: from [216.101.162.242] ([216.101.162.242]:4224 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270578AbRHIU0S>;
	Thu, 9 Aug 2001 16:26:18 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15218.61869.424038.30544@pizda.ninka.net>
Date: Thu, 9 Aug 2001 13:25:17 -0700 (PDT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: johannes@erdfelt.com (Johannes Erdfelt), linux-kernel@vger.kernel.org
Subject: Re: struct page to 36 (or 64) bit bus address?
In-Reply-To: <E15UvLO-0007tH-00@the-village.bc.nu>
In-Reply-To: <20010809151022.C1575@sventech.com>
	<E15UvLO-0007tH-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
 > > Obviously the more portable way across architectures is using the PCI
 > > DMA API but when will the implementation be fixed so I can use it to
 > > exploit the full potential of this device?
 > 
 > 2.5 I believe, ping the peacefrog and ask <DaveM@redhat.com>

That's the current plan.  There may be a 2.4.x backport, but no
promises.  It all depends upon how straightforward the changes
are.

Note, if you use the "bttv method" (ie. virt_to_bus) your driver will
then fail to compile on several platforms.

Later,
David S. Miller
davem@redhat.com
