Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268702AbRGZWI2>; Thu, 26 Jul 2001 18:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268700AbRGZWIT>; Thu, 26 Jul 2001 18:08:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24082 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268704AbRGZWIF>; Thu, 26 Jul 2001 18:08:05 -0400
Subject: Re: [CHECKER] repetitive/contradictory comparison bugs for 2.4.7
To: rmk@arm.linux.org.uk (Russell King)
Date: Thu, 26 Jul 2001 23:07:36 +0100 (BST)
Cc: linux-kernel@alex.org.uk (Alex Bligh - linux-kernel),
        torvalds@transmeta.com, tytso@valinux.com,
        engler@csl.stanford.edu (Dawson Engler),
        alan@lxorguk.ukuu.org.uk (Alan Cox), nave@stanford.edu (Evan Parker),
        linux-kernel@vger.kernel.org, mc@cs.stanford.edu
In-Reply-To: <20010726211558.F2200@flint.arm.linux.org.uk> from "Russell King" at Jul 26, 2001 09:15:58 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PtI9-0004as-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> >    static char * tmp_buf;
> 
> Here is the fix...  I've updated it a bit to plug another small race in
> rs_write as well.

It runs under lock_kernel so thats complete overkill
