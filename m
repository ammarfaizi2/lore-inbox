Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291549AbSBTBws>; Tue, 19 Feb 2002 20:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291589AbSBTBwc>; Tue, 19 Feb 2002 20:52:32 -0500
Received: from sushi.toad.net ([162.33.130.105]:25522 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S291533AbSBTBvX>;
	Tue, 19 Feb 2002 20:51:23 -0500
Subject: Re: 2.5.4 PNPBIOS fault
From: Thomas Hood <jdthood@mail.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0202191501450.1465-100000@dragon.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33L2.0202191501450.1465-100000@dragon.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 19 Feb 2002 20:51:43 -0500
Message-Id: <1014169905.4978.18.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-19 at 18:05, Randy.Dunlap wrote:
> Linux 2.5.4 with CONFIG_PNPBIOS=y and "pnpbios=off" oopses
> in ahc_linux_isr() (or near there, according to the
> System.map file).

Well, that tells us a lot, because with "pnpbios=off"
the init routine returns immediately without calling
the BIOS.  It would appear that this isn't a PnP BIOS
coding bug, but something subtle.


