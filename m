Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272109AbRIEL5l>; Wed, 5 Sep 2001 07:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272115AbRIEL53>; Wed, 5 Sep 2001 07:57:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25860 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272109AbRIEL5Q>; Wed, 5 Sep 2001 07:57:16 -0400
Subject: Re: IDE Problems on SIS 735?
To: kernel@corrosive.freeserve.co.uk
Date: Wed, 5 Sep 2001 13:01:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010905085251.A3154@corrosive.freeserve.co.uk> from "kernel@corrosive.freeserve.co.uk" at Sep 05, 2001 08:52:51 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ebN4-0005g4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> search for the meaning of the error message I'm getting, but I must be looking
> in the wrong places since I can't seem to find something that explains it
> fully.  Since this chipset is fairly new I thought I'd mention it here to see
> if anyone has an idea what might be wrong (I'm suspecting the cables, but I've
> already swapped them over once..).

The driver tried to do a UDMA transfer, and waited and waited, and gave up
on it. With cable errors I'd expect to see a badCRC message or two.

Does it behave better with an older kernel (say 2.4.7 or so) ?
