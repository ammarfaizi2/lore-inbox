Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279429AbRKASJu>; Thu, 1 Nov 2001 13:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279454AbRKASJj>; Thu, 1 Nov 2001 13:09:39 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:40456 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S279429AbRKASJV>;
	Thu, 1 Nov 2001 13:09:21 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111011809.VAA26876@ms2.inr.ac.ru>
Subject: Re: Bind to protocol with AF_PACKET doesn't work for outgoing packets
To: ak@suse.de (Andi Kleen)
Date: Thu, 1 Nov 2001 21:09:07 +0300 (MSK)
Cc: ak@suse.de, joris@deadlock.et.tudelft.nl, linux-kernel@vger.kernel.org
In-Reply-To: <20011101184511.A22234@wotan.suse.de> from "Andi Kleen" at Nov 1, 1 06:45:11 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> First if you really meant this dev_xmit_nit() (which you added) could be 
> removed.

Sorry? It is used by packet sniffers.


> ugly imho; if the feature exists it should be implemented for the full
> packet functionality which includes binding to protocols.

This is a silly abuse. Sniffers do not bind to protocols, should not
do this and have no reasons to do this.


>  I think the patch should be added.

That which adds all the packet sockets to ptype_all? Do you jest? :-)

Alexey
