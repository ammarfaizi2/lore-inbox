Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267937AbRGRV0p>; Wed, 18 Jul 2001 17:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267936AbRGRV0f>; Wed, 18 Jul 2001 17:26:35 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:32009 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267930AbRGRV0c>; Wed, 18 Jul 2001 17:26:32 -0400
Date: Wed, 18 Jul 2001 14:25:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Arjan van de Ven <arjanv@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: acpi patch in 2.4.6
In-Reply-To: <20010718152333.A3393@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33.0107181424480.1159-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jul 2001, Arjan van de Ven wrote:
>
> How is the following chunk taken from patch-2.4.6 ever going to work ?

Because ACPI physical addresses are _physical_ memory addresses, and we
have a 1:1 mapping for most of them (notably the BIOS extended areas).

		Linus

