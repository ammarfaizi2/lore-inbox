Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129424AbRBYQ7B>; Sun, 25 Feb 2001 11:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRBYQ6u>; Sun, 25 Feb 2001 11:58:50 -0500
Received: from www.wen-online.de ([212.223.88.39]:10771 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129424AbRBYQ6g>;
	Sun, 25 Feb 2001 11:58:36 -0500
Date: Sun, 25 Feb 2001 17:58:32 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marc Lehmann <pcg@goof.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux swap freeze STILL in 2.4.x
In-Reply-To: <20010225155929.A371@cerebro.laendle>
Message-ID: <Pine.LNX.4.33.0102251745360.568-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Feb 2001, Marc Lehmann wrote:

> It seems linux-2.4 still freezes on out-of-memory situations:

<snip>

> Usually I swapon ./swap some 512MB swapfile, but today I forgot it. When the
> machine started to get sluggish I sent the process a -STOP signal.

Signal delivery during oomest does not work (last time I tested).
Andrea fixed this once.. long time ~problem.

	-Mike

