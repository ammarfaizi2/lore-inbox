Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270987AbTHGUv4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270986AbTHGUv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:51:56 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:10385 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S270987AbTHGUvz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:51:55 -0400
Date: Thu, 7 Aug 2003 22:51:31 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <linux-kernel@vger.kernel.org>
cc: <Andries.Brouwer@cwi.nl>
Subject: ide-tape broken (was Re: [PATCH] use ide-identify.h, fix endian bug)
In-Reply-To: <UTC200308072012.h77KCtf02202.aeb@smtp.cwi.nl>
Message-ID: <Pine.SOL.4.30.0308072244170.23618-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Aug 2003 Andries.Brouwer@cwi.nl wrote:

> Given ide-identify.h, we can simplify ide-floppy.c and ide-tape.c a lot.
> In fact ide-tape.c was broken on big-endian machines.
> (Unfortunately much more is broken that was fixed here,
> ide-tape.c is not in a good shape today.)

ide-tape is broken because nobody cares, so I don't care too
(was broken even before).  It needs rewrite and testing.

So once again if anybody cares and has hardware to test,
please contact me and I will try fix it.

Until then I don't touch it et all and consider it obsoleted.

--bartlomiej

