Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269468AbRGaU3m>; Tue, 31 Jul 2001 16:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269466AbRGaU3d>; Tue, 31 Jul 2001 16:29:33 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:12611 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S269453AbRGaU3R>; Tue, 31 Jul 2001 16:29:17 -0400
Date: Tue, 31 Jul 2001 15:29:22 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Marc ZYNGIER <mzyngier@freesurf.fr>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>, rth@twiddle.net
Subject: Re: [RFC][PATCH] Exporting ___raw_readw and friends on Alpha
In-Reply-To: <wrpn15k97fq.fsf@hina.wild-wind.fr.eu.org>
Message-ID: <Pine.LNX.3.96.1010731152829.30354A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 31 Jul 2001, Marc ZYNGIER wrote:
> Two symbols were missing from the export list : ___raw_readw and
> ___raw_writew.

Ok with me...  __raw_foo can be used in drivers that know what they are
doing for better performance.

	Jeff



