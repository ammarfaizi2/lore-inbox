Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268685AbUIQKwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268685AbUIQKwX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 06:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268672AbUIQKwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 06:52:22 -0400
Received: from witte.sonytel.be ([80.88.33.193]:58063 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268685AbUIQKvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 06:51:08 -0400
Date: Fri, 17 Sep 2004 12:50:22 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Colin Leroy <colin@colino.net>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pmac: don't add =?ISO-8859-1?Q?=22=B0C=22?= suffix in
 sys for adt746x driver
In-Reply-To: <1095401127.5105.73.camel@gaston>
Message-ID: <Pine.GSO.4.58.0409171249500.19914@waterleaf.sonytel.be>
References: <1095401127.5105.73.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004, Benjamin Herrenschmidt wrote:
> The adt746x driver currently adds a "°C" suffix to temperatures exposed
> via sysfs, and I don't like that. First, we all agree that any other unit
> here makes no sense (do we ? do we ? yes of course :) and I don't like

Universal temperature, in K? And you'll never ever see negative numbers ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
