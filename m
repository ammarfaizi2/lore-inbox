Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132098AbRACFRf>; Wed, 3 Jan 2001 00:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132172AbRACFR0>; Wed, 3 Jan 2001 00:17:26 -0500
Received: from www.wen-online.de ([212.223.88.39]:22800 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S132098AbRACFRI>;
	Wed, 3 Jan 2001 00:17:08 -0500
Date: Wed, 3 Jan 2001 05:46:42 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: scheduling problem?
In-Reply-To: <3A52609D.E1D466EA@innominate.de>
Message-ID: <Pine.Linu.4.10.10101030545440.1057-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Daniel Phillips wrote:

> Could you try this patch just to see what happens?  It uses semaphores
> for the bdflush synchronization instead of banging directly on the task
> wait queues.  It's supposed to be a drop-in replacement for the bdflush
> wakeup/waitfor mechanism, but who knows, it may have subtly different
> behavious in your case.

Semaphore timed out during boot, leaving bdflush as zombie.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
