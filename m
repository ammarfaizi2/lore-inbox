Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276698AbRJGV5W>; Sun, 7 Oct 2001 17:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276701AbRJGV5M>; Sun, 7 Oct 2001 17:57:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31241 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276699AbRJGV5B>; Sun, 7 Oct 2001 17:57:01 -0400
Subject: Re: %u-order allocation failed
To: mikulas@artax.karlin.mff.cuni.cz (Mikulas Patocka)
Date: Sun, 7 Oct 2001 23:01:45 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), riel@conectiva.com.br (Rik van Riel),
        kszysiu@main.braxis.co.uk (Krzysztof Rusocki), linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1011007173411.6774A-100000@artax.karlin.mff.cuni.cz> from "Mikulas Patocka" at Oct 07, 2001 05:42:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qLzV-00071D-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The difference between memory and vmalloc space is this: you fill up the
> whole memory with cache => memory fragments. You don't fill up the whole
> vmalloc space with anything => vmalloc space doesn't fragment.

vmalloc space fragments. You fragment address space rather than pages thats
all. Same problem

