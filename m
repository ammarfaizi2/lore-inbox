Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275644AbRIZVy6>; Wed, 26 Sep 2001 17:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275646AbRIZVys>; Wed, 26 Sep 2001 17:54:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16137 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275644AbRIZVyk>; Wed, 26 Sep 2001 17:54:40 -0400
Subject: Re: Binary only module overview
To: ignacio@openservices.net (Ignacio Vazquez-Abrams)
Date: Wed, 26 Sep 2001 22:58:35 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109261743400.27586-100000@terbidium.openservices.net> from "Ignacio Vazquez-Abrams" at Sep 26, 2001 05:45:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mMhP-00021p-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What about programs that include header files from /usr/include/linux,
> /usr/include/asm, and/or /usr/include/scsi?

I believe you cannot copyright an interface just an implementation of it.
I suspect someone more familiar in law can give the required precise info
on that boundary

That is the security layer issue is one of "does it depend on the linux
kernel to work, is it deriving from the kernel and the GPL'd module for
security plugins" not about the precise structs and #defines.

Given the SSSCA we have to be very clear on this issue, and if its not clear
I might be best to kill the entire uncertainty by not including the LSM
patch in Linux until the US government returns to sanity
