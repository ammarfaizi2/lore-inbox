Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293745AbSCKNyN>; Mon, 11 Mar 2002 08:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310119AbSCKNx4>; Mon, 11 Mar 2002 08:53:56 -0500
Received: from mail.scram.de ([195.226.127.117]:51693 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S293745AbSCKNxT>;
	Mon, 11 Mar 2002 08:53:19 -0500
Date: Mon, 11 Mar 2002 14:53:14 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
To: Kurt Garloff <garloff@suse.de>
cc: <linux-kernel@vger.kernel.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jay Estabrook <Jay.Estabrook@compaq.com>,
        Richard Henderson <rth@twiddle.net>
Subject: Re: Busmaster DMA broken in 2.4.18 on Alpha
In-Reply-To: <20020311124511.J2346@nbkurt.etpnet.phys.tue.nl>
Message-ID: <Pine.NEB.4.33.0203111449310.1745-100000@www2.scram.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kurt,

> You have a Miata mainboard, right?

Nope. It's an Avanti board (Alpha Server 400).

> Unfortunately, your ISA card does not seem to be able to address 32 bits.
> (I guess no non-on-chip ISA adapter will.)

IIRC, the ISA bus only has a 24bit address bus.

> Seems we need two different ISA_DMA_MASKS ...

Looks like it.

Cheers,
--jochen

