Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280813AbRKGPQ5>; Wed, 7 Nov 2001 10:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280814AbRKGPQr>; Wed, 7 Nov 2001 10:16:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21508 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280813AbRKGPQi>; Wed, 7 Nov 2001 10:16:38 -0500
Subject: Re: ext3 vs resiserfs vs xfs
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Wed, 7 Nov 2001 15:23:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111071558090.29292-100000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at Nov 07, 2001 04:00:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161UYR-0004S5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just set up a RedHat 7.2 box with ext3, and after a few tests/chrashes,
> I see no difference at all. After a chrash, it really wants to run fsck
> anyway. I've tried ReiserFS before, with no fsck after chrashes - is this

Umm RH 7.2 after an unexpected shutdown will give you a 5 second count down
when you can choose to force an fsck - ext3 doesnt need an fsck but
sometimes folks might want to force it thats all
