Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277618AbRJHXjw>; Mon, 8 Oct 2001 19:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277620AbRJHXjn>; Mon, 8 Oct 2001 19:39:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20996 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277618AbRJHXjh>; Mon, 8 Oct 2001 19:39:37 -0400
Subject: Re: %u-order allocation failed
To: mikulas@artax.karlin.mff.cuni.cz (Mikulas Patocka)
Date: Tue, 9 Oct 2001 00:44:00 +0100 (BST)
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        riel@conectiva.com.br (Rik van Riel),
        linux-kernel@alex.org.uk (Alex Bligh - linux-kernel),
        kszysiu@main.braxis.co.uk (Krzysztof Rusocki), linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1011009010928.13677A-100000@artax.karlin.mff.cuni.cz> from "Mikulas Patocka" at Oct 09, 2001 01:31:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qk40-0002Jf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus, what do you think: is it OK if fork randomly fails with very small
> probability or not?

Your code doesnt change that behaviour. Not one iota. Do the mathematics,
work out the failure probabilities for page pairs. Now remember that the
vmalloc one has guard pages too.

You are trying to solve a non problem with a non solution

Alan
