Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319024AbSHFJD6>; Tue, 6 Aug 2002 05:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319025AbSHFJD6>; Tue, 6 Aug 2002 05:03:58 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:6101 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S319024AbSHFJDp>; Tue, 6 Aug 2002 05:03:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] 18/18 scsi core changes
Date: Tue, 6 Aug 2002 13:06:03 +0200
User-Agent: KMail/1.4.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, "Aron Zeh" <ARZEH@de.ibm.com>
References: <200208051830.50713.arndb@de.ibm.com> <200208052008.35187.arndb@de.ibm.com> <20020805181234.B16035@infradead.org>
In-Reply-To: <20020805181234.B16035@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208061306.03627.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 August 2002 19:12, Christoph Hellwig wrote:
> It absolutely does not look good for inclusion.
OK, thanks for looking at it. Maybe the zfcp developers can
find a less intrusive way of getting the driver to work
if they want it to work out of the box.

> the zfcp driver itself is so ugly that I wonder you even show it
> publically..
The other new drivers I sent (lcs, z90crypt and qdio) and some of 
the s390 stuff that's already in 2.4 are not really any better.
These three have all been closed source before and you can see
them as a warning of what happens to your code if you skip
public peer review ;-)
Still, it's the stuff IBM recommends for use and it's not going
away (at least not in 2.4), so I guess it might just as well be 
included.

OTOH, if Marcello wants to the next patch size small, it might be
a good idea to leave out the uglier drivers.

	Arnd <><
