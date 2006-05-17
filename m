Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWEQNCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWEQNCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWEQNCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:02:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50150 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932243AbWEQNCE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:02:04 -0400
Subject: Re: 2.6.17-rc4-mm1: please drop
	add-raw-driver-kconfig-entry-for-s390.patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Ihno Krumreich <ihno@suse.de>, Olaf Hering <olh@suse.de>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
In-Reply-To: <20060516161228.GF5677@stusta.de>
References: <20060515005637.00b54560.akpm@osdl.org>
	 <20060516161228.GF5677@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 14:12:33 +0100
Message-Id: <1147871553.10470.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-16 at 18:12 +0200, Adrian Bunk wrote:
> Since it seems the NAK's of Christoph and Martin weren't enough:
>   NAK++

Then lets add an ACK++ as well

> This driver is declared obsolete since more than two years, and while 
> it's worth a discussion how long to keep it for legacy users, merging a 
> patch offering an obsolete driver for even more users is silly.

The real world expects a raw driver. Application authors also expect the
same functionality on all platforms. 

Also in truth you can NACK and "obsolete" the raw devices all you like,
nobody in the distribution world will drop it because it is part of
"standard" unix/linux OS functionality and has been for longer than
Linux even existed. If you want to fork Linux between "Linux the real
world", and "Linux the abstract unused by anyone perfection" that's a
fine way to ensure such a split happens.

You know the O_DIRECT stuff is better, I know the O_DIRECT stuff is
better, but so was betamax and so is a Dvorak keyboard...

I happen to like "Linux the real world OS", if I wanted to run something
more abstractly elegant then I'd download Plan 9. 

ACK

Alan

