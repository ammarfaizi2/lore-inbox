Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133013AbRD3A3z>; Sun, 29 Apr 2001 20:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136419AbRD3A3p>; Sun, 29 Apr 2001 20:29:45 -0400
Received: from anime.net ([63.172.78.150]:23556 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S133013AbRD3A3c>;
	Sun, 29 Apr 2001 20:29:32 -0400
Date: Sun, 29 Apr 2001 17:29:05 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
cc: <linux-kernel@vger.kernel.org>, <jgarzik@mandrakesoft.com>
Subject: Re: 2.4.4 Sound corruption [FIXED]
In-Reply-To: <20010430021015.A7925@dutidad.twi.tudelft.nl>
Message-ID: <Pine.LNX.4.30.0104291722280.19431-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Charl P. Botha wrote:
> I have removed this code and everything is now fine on my system.  The
> problem is that the 686A and 686B have the same PCI IDs, else I would have
> submitted a patch.

686a is rev 0x10 - 0x2f, 686b is rev 0x40 - 0x4f.

The fixup code should take this into account.

-Dan

