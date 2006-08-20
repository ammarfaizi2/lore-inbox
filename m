Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWHTSEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWHTSEW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 14:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWHTSEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 14:04:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:24812 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751099AbWHTSEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 14:04:21 -0400
Subject: Re: [Patch] Fix signedness error in drivers/media/video/vivi.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org, mchehab@infradead.org
In-Reply-To: <1156004367.17863.2.camel@alice>
References: <1156004367.17863.2.camel@alice>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Aug 2006 19:25:27 +0100
Message-Id: <1156098327.4051.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-08-19 am 18:19 +0200, ysgrifennodd Eric Sesterhenn:
> Since videobuf_reqbufs() returns negative values on errors the current
> code does no real error checking since gcc removes the comparison.
> This patch fixes this issue by making ret a normal, signed integer.
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 

Doesn't apply to latest driver tree but the problem is still present.

Alan

