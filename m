Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272295AbRIEWHr>; Wed, 5 Sep 2001 18:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272314AbRIEWHg>; Wed, 5 Sep 2001 18:07:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32009 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272295AbRIEWH0>; Wed, 5 Sep 2001 18:07:26 -0400
Subject: Re: lilo vs other OS bootloaders was: FreeBSD makes progress
To: andrew.grover@intel.com (Grover, Andrew)
Date: Wed, 5 Sep 2001 23:11:35 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE0ED@orsmsx35.jf.intel.com> from "Grover, Andrew" at Sep 05, 2001 02:18:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ektU-0006qw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, I'm not sure whether this would really hurt overall kernel
> performance, for two reasons: First, I would think that the requirement to
> use the lock instruction would overshadow any function call overhead.

AMD lock overhead for an L1 cached exclusive line is basically on the 
synchronization point, it doesn't go to memory. I believe later Pentium I*
do the same. 

Alan
