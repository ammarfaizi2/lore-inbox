Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262932AbSJHM7g>; Tue, 8 Oct 2002 08:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262976AbSJHM7g>; Tue, 8 Oct 2002 08:59:36 -0400
Received: from [217.167.51.129] ([217.167.51.129]:27130 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S262932AbSJHM7f>;
	Tue, 8 Oct 2002 08:59:35 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Alexander Viro" <viro@math.psu.edu>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Patrick Mochel" <mochel@osdl.org>,
       "Linus Torvalds" <torvalds@transmeta.com>,
       "Andre Hedrick" <andre@linux-ide.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IDE driver model update
Date: Tue, 8 Oct 2002 17:05:35 +0200
Message-Id: <20021008150535.27896@192.168.4.1>
In-Reply-To: <Pine.GSO.4.21.0210080813030.2894-100000@weyl.math.psu.edu>
References: <Pine.GSO.4.21.0210080813030.2894-100000@weyl.math.psu.edu>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Ouch.  That (reconnects) may require interesting things from queue-related
>code.  What behaviour do you want while card is disconnected?  All requests
>getting errors / all requests getting blocked / reads failing, writes
>blocking?

Same problem I beleive with the hotswap ATAPI bay I have on some
machines, and probably very similar at the queue level to the
problem of USB & FireWire drives.


Ben.


