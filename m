Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265636AbTIJTUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265603AbTIJTUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:20:22 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:23480 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265636AbTIJTUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:20:16 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030910.211509.184824199.rene.rebe@gmx.net>
References: <20030910.211509.184824199.rene.rebe@gmx.net>
Message-Id: <1063221565.678.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 10 Sep 2003 21:19:25 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: dmasound_pmac (2.4.x{,-benh}) does not restore mixer during
	PM-wake
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The code in tas3004_leave_sleep() looks ok so ... any idea (maybe I
> need to add a printk do test if it is really called?)?

Either that or we need some delay after powering the chip back
up and before we can write to its mixer ?

ben.


