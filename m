Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272020AbRIIQJL>; Sun, 9 Sep 2001 12:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272039AbRIIQJC>; Sun, 9 Sep 2001 12:09:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64260 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272020AbRIIQIu>; Sun, 9 Sep 2001 12:08:50 -0400
Subject: Re: Purpose of the mm/slab.c changes
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sun, 9 Sep 2001 17:12:50 +0100 (BST)
Cc: andrea@suse.de (Andrea Arcangeli), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox), torvalds@transmeta.com
In-Reply-To: <001201c13942$b1bec9a0$010411ac@local> from "Manfred Spraul" at Sep 09, 2001 05:18:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15g7CU-0007LK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> lifo/fifo for unused slabs is obviously superflous - free is free, it
> doesn't matter which free page is used first/last.

Which pages are likely to be in the CPU caches ?
