Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262502AbRENVYM>; Mon, 14 May 2001 17:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262503AbRENVYC>; Mon, 14 May 2001 17:24:02 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1546 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262502AbRENVX4>; Mon, 14 May 2001 17:23:56 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: neilb@cse.unsw.edu.au (Neil Brown)
Date: Mon, 14 May 2001 22:20:06 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
In-Reply-To: <15104.17957.253821.765483@notabene.cse.unsw.edu.au> from "Neil Brown" at May 15, 2001 06:55:01 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zPl9-0001S9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This means that we need some analogue to {get,put}_unnamed_dev that
> manages a range of dynamically allocated majors.
> Is there such a beast already, or does someone need to write it?
> What range(s) should be used for block devices? 
> 
> Am I missing something obvious here?

Obvious question: Do you need your majors to be together in order, or can
you pick 8 random numbers each boot and expect the user to cope ?

Equally if they were static numbers do they have to be together or scattered ?

