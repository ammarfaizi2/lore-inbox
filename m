Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274768AbRIUGL0>; Fri, 21 Sep 2001 02:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274769AbRIUGLS>; Fri, 21 Sep 2001 02:11:18 -0400
Received: from [209.202.108.240] ([209.202.108.240]:17161 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S274768AbRIUGLG>; Fri, 21 Sep 2001 02:11:06 -0400
Date: Fri, 21 Sep 2001 02:11:15 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] parport_pc.c PnP BIOS sanity check
In-Reply-To: <3BAAD796.A766FBEC@yahoo.co.uk>
Message-ID: <Pine.LNX.4.33.0109210209520.21008-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, Thomas Hood wrote:

> I'm still wondering why this function in parport_pc.c rejects dma
> values of zero.  Is DMA0 not usable by the parallel port for some
> reason?  I should think that if the PnP BIOS returns a dma of zero
> then it means that the parallel port is using DMA0.  Sorry if I'm
> being obtuse.                      // Thomas Hood

DMA0 is reserved for memory refresh. It _can't_ be used for anything else,
therefore a value of 0 is representative of no value whatsoever.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

