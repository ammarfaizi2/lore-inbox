Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbTLSUHx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 15:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbTLSUHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 15:07:53 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:23181 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263596AbTLSUHr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 15:07:47 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [patch] ide.c as a module
Date: Fri, 19 Dec 2003 21:10:19 +0100
User-Agent: KMail/1.5.4
Cc: khc@pm.waw.pl, linux-kernel@vger.kernel.org
References: <20031211202536.GA10529@starbattle.com> <200312191726.46147.bzolnier@elka.pw.edu.pl> <20031219090541.10fae126.rddunlap@osdl.org>
In-Reply-To: <20031219090541.10fae126.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312192110.19393.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 of December 2003 18:05, Randy.Dunlap wrote:
> On Fri, 19 Dec 2003 17:26:46 +0100 Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> | On Thursday 18 of December 2003 01:29, Krzysztof Halasa wrote:
> | > BTW: modular IDE in 2.4.23 is still problematic - you can't unload the
> | > chipset driver (piix.o or something like) which in turn references the
> | > core IDE module.
> |
> | It is probably too much work to fix it (properly) in 2.4.x and 2.6.x...
> |
> | Please note that there is no refcounting in IDE drivers,
> | there is no host object type, also table of IDE ports (ide_hwifs[]) is
> | static.
> |
> | I hope 2.7 will obsolete drivers/ide...
>
> in favor of libata or what?

yes, in favor of libata, but don't tell jeff ;-).

--bart

