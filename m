Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbQKPVHQ>; Thu, 16 Nov 2000 16:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQKPVHG>; Thu, 16 Nov 2000 16:07:06 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2308 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129199AbQKPVGs>;
	Thu, 16 Nov 2000 16:06:48 -0500
Message-ID: <20001116003646.A2549@bug.ucw.cz>
Date: Thu, 16 Nov 2000 00:36:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rik van Riel <riel@conectiva.com.br>,
        Andreas Osterburg <alanos@first.gmd.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swapping over NFS in Linux 2.4?
In-Reply-To: <00111517064807.29351@bar> <Pine.LNX.4.21.0011151421580.5584-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0011151421580.5584-100000@duckman.distro.conectiva>; from Rik van Riel on Wed, Nov 15, 2000 at 02:23:24PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Because I set up a diskless Linux-workstation, I want to swap
> > over NFS. For this purpose I found only patches for "older"
> > Linux-versions (2.0, 2.1, 2.2?).
> 
> > Does anyone know wheter there are patches for 2.4 or does anyone
> > know another solution for this problem?
> 
> 1. you can swap over NBD

Are you sure, Rik? So we no longer have low-memory deadlocks in nbd?
Wow, there used to be plenty of them in past.

Do you promise it is possible to swap over NBD?


> 2. if you point me to the swap-over-nfs patches you
>    have found, I can try to make them work on 2.4 ;)

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
