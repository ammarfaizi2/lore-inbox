Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265360AbRF0Sjg>; Wed, 27 Jun 2001 14:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265364AbRF0Sj0>; Wed, 27 Jun 2001 14:39:26 -0400
Received: from gracie.userfriendly.org ([204.174.17.66]:13326 "EHLO
	gracie.userfriendly.org") by vger.kernel.org with ESMTP
	id <S265360AbRF0SjO>; Wed, 27 Jun 2001 14:39:14 -0400
Date: Wed, 27 Jun 2001 11:39:10 -0700
From: Jay Thorne <Yohimbe@userfriendly.org>
To: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [noOOPS] Crash in -ac15 on SMP init fixed in -ac19
Message-Id: <20010627113910.0405d533.Yohimbe@userfriendly.org>
Organization: Userfriendly
X-Mailer: Sylpheed version 0.5.0pre2 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Operating-System: Silly
X-Crash-MS: Now
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dunno what the problem was, but the 2.4.5-ac15 problem I was having on the
4 way alphas is fixed in ac19. 

>Unable to handle kernel paging request at virtual address
043ffc000069c078
>CPU 2 init(1): Oops 0
>pc = [<fffffc000034550c>]  ra = [<fffffc00003456ac>]  ps = 0000

Anyone venture a guess? The patch log does not seem to show specific
mentions of mm fixups from ac15 to 19

--
Jay Thorne Manager, Systems & Technology, UserFriendly Media, Inc.
