Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275398AbRIZSJb>; Wed, 26 Sep 2001 14:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275405AbRIZSJV>; Wed, 26 Sep 2001 14:09:21 -0400
Received: from zeus.kernel.org ([204.152.189.113]:43652 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S275398AbRIZSJM>;
	Wed, 26 Sep 2001 14:09:12 -0400
Subject: Re: Locking comment on shrink_caches()
To: davej@suse.de (Dave Jones)
Date: Wed, 26 Sep 2001 19:07:10 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        davem@redhat.com (David S. Miller), bcrl@redhat.com,
        marcelo@conectiva.com.br, andrea@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0109261958290.8655-100000@Appserv.suse.de> from "Dave Jones" at Sep 26, 2001 07:59:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mJ5S-0001LS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> nothing: 30 cycles
> locked add: 31 cycles
> cpuid: 79 cycles
> 
> Only slightly worse, but I'd not expected this.
> This was from a 866MHz part too, whereas you have a 533 iirc ?

The 0.13u part has a couple more pipeline steps I believe
