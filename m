Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbRENULW>; Mon, 14 May 2001 16:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262471AbRENULO>; Mon, 14 May 2001 16:11:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64520 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262464AbRENULC>; Mon, 14 May 2001 16:11:02 -0400
Subject: Re: Minor numbers
To: Andries.Brouwer@cwi.nl
Date: Mon, 14 May 2001 21:06:40 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, R.E.Wolff@bitwizard.nl, aqchen@us.ibm.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <UTC200105141809.UAA09657.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at May 14, 2001 08:09:45 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zOc4-0001Kk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm. You make me search for this old patch.
> Since Linus' reaction was not exactly positive I left
> the topic again, but there must be a copy somewhere..

Given current real world evolution Im very interested in 32bit dev_t or at
least implementing the 'lots of majors' half of it because we are probably
going to need it in the 2.5 years before we have a 2.6

> The system call itself cannot easily be changed to take a larger dev_t,
> mostly because under old glibc the high order part would be random.

Is that true or is it always happening to be clear ? I was rather hoping all
C libraries happened to clear the upper half 

