Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266258AbUHBFKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266258AbUHBFKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 01:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266259AbUHBFKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 01:10:35 -0400
Received: from digitalimplant.org ([64.62.235.95]:20380 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S266258AbUHBFKe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 01:10:34 -0400
Date: Sun, 1 Aug 2004 22:10:18 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
cc: Pavel Machek <pavel@ucw.cz>, "" <linux-kernel@vger.kernel.org>
Subject: Re: [6/25] Merge pmdisk and swsusp
In-Reply-To: <410DCB45.7060407@kolumbus.fi>
Message-ID: <Pine.LNX.4.50.0408012208300.8159-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0407171528280.22290-100000@monsoon.he.net>
 <20040718220954.GB31958@atrey.karlin.mff.cuni.cz>
 <Pine.LNX.4.50.0408012018370.30101-100000@monsoon.he.net> <410DCB45.7060407@kolumbus.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2 Aug 2004, [ISO-8859-1] Mika Penttilä wrote:

> Why alloc twice for the saved pages, once in calc_order() and then in
> alloc_image_pages() ?

There is only one allocation each for both the pagedir (in
alloc_pagedir()) and the image pages (in alloc_image_pages()). So, I'm not
sure what you mean..

Thanks,


	Pat
