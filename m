Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277003AbRJKWOA>; Thu, 11 Oct 2001 18:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276997AbRJKWNj>; Thu, 11 Oct 2001 18:13:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31240 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276990AbRJKWNi>; Thu, 11 Oct 2001 18:13:38 -0400
Subject: Re: Module read a file?
To: mra@pobox.com (Mark Atwood)
Date: Thu, 11 Oct 2001 23:18:54 +0100 (BST)
Cc: cfriesen@nortelnetworks.com (Christopher Friesen),
        linux-kernel@vger.kernel.org (Linux Kernel Development)
In-Reply-To: <m3zo6xswcq.fsf@flash.localdomain> from "Mark Atwood" at Oct 11, 2001 02:25:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15roAI-000539-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Because the firmware is stored in volitile memory on the card, and
> vanishes on a card reset or removal, and I would like to have it Just
> Work with the pcmcia-cs package with minimal changes.

Longer term that is precisely what the hot plug interface is there fore

> Having to remember "run this userspace tool after every card reset"
> (which includes power suspends and so forth) would be a major pain.
> 
> Besides, the card already has a good validator in it.

What do you do if the card is compiled in and initialised before the
firmware holding fs is mounted ?
