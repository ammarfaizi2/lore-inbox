Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270824AbTHGUUr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270766AbTHGUUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:20:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58760 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S270824AbTHGUUl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:20:41 -0400
Date: Thu, 7 Aug 2003 22:20:20 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <Andries.Brouwer@cwi.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kill superfluous capacity
In-Reply-To: <UTC200308072009.h77K9hm01960.aeb@smtp.cwi.nl>
Message-ID: <Pine.SOL.4.30.0308072216520.4726-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Aug 2003 Andries.Brouwer@cwi.nl wrote:

> We have both capacity and capacity48.
> Kill one of them.  A nice simplification.
>
> [I left capacity48 instead of capacity on the one hand
> to remind users that it is 64 bits, and on the other hand
> because that is easier to grep for. We have enough uses
> of capacity already.]

Thanks, looks beatiful.  I'll apply and push to Linus later.

Very minor issue, what about renaming drive->capacity48 to
drive->capacity64 to avoid confusion (we now use it also for
LBA-28 and CHS).

--bartlomiej

