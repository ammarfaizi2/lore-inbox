Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312290AbSC2XFB>; Fri, 29 Mar 2002 18:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312294AbSC2XEm>; Fri, 29 Mar 2002 18:04:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55310 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312290AbSC2XEj>; Fri, 29 Mar 2002 18:04:39 -0500
Subject: Re: [RFC] kmem_cache_zalloc
To: pavel@ucw.cz (Pavel Machek)
Date: Fri, 29 Mar 2002 23:21:17 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        tigran@aivazian.fsnet.co.uk (Tigran Aivazian),
        sandeen@sgi.com (Eric Sandeen), linux-kernel@vger.kernel.org
In-Reply-To: <20020329221720.GB9974@elf.ucw.cz> from "Pavel Machek" at Mar 29, 2002 11:17:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16r5gL-0002BV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Much more useful would be kcalloc(). That way we can put all the missing 
> > 32bit overflow checking into kcalloc and remove a lot of crud from the
> > kernel where we have to keep doing maths checks.
> 
> What should kcalloc do?

The same as calloc in standard C, but also make sure it does overflow checking.
