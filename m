Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261548AbSIZVyw>; Thu, 26 Sep 2002 17:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261549AbSIZVyw>; Thu, 26 Sep 2002 17:54:52 -0400
Received: from AMarseille-201-1-5-50.abo.wanadoo.fr ([217.128.250.50]:4464
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261548AbSIZVyv>; Thu, 26 Sep 2002 17:54:51 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Richard Zidlicky" <rz@linux-m68k.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linus Torvalds" <torvalds@transmeta.com>,
       "Andre Hedrick" <andre@linux-ide.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Jens Axboe" <axboe@suse.de>
Subject: Re: [PATCH] fix ide-iops for big endian archs
Date: Thu, 26 Sep 2002 23:03:04 +0200
Message-Id: <20020926210304.19470@192.168.4.1>
In-Reply-To: <20020926225847.B2242@linux-m68k.org>
References: <20020926225847.B2242@linux-m68k.org>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>to put it a bit more precise, this is bus endianness, nothing to 
>do with arch endianness.

Well, right, though this is also the way a PCI bus is supposed
to be wired to a BE CPU, and is the most common way to wire a
bus with ISA-like chipsets (16 bits busses) on a BE core ;)

Ben.


