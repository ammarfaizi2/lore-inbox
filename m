Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267392AbTCEQaw>; Wed, 5 Mar 2003 11:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267425AbTCEQaw>; Wed, 5 Mar 2003 11:30:52 -0500
Received: from air-2.osdl.org ([65.172.181.6]:46782 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267392AbTCEQat>;
	Wed, 5 Mar 2003 11:30:49 -0500
Date: Wed, 5 Mar 2003 10:16:46 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Dominik Brodowski <linux@brodo.de>
cc: <torvalds@transmeta.com>, <jt@hpl.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       <mika.penttila@kolumbus.fi>
Subject: Re: [PATCH] driver model: fix platform_match [Was: Re: [PATCH]
 pcmcia: get initialization ordering right [Was: [PATCH 2.5] : i82365 &
 platform_bus_type]]
In-Reply-To: <20030305063912.GA2520@brodo.de>
Message-ID: <Pine.LNX.4.33.0303051016230.994-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Unfortunately, this won't work: digits are perfectly valid entries of
> strings. However, we have the name without the appending instance still
> saved in platform_device pdev->name... so what about this?

D'oh. You're completely right. 

Thanks,


	-pat

