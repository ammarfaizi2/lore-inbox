Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263033AbREaPIj>; Thu, 31 May 2001 11:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263032AbREaPI3>; Thu, 31 May 2001 11:08:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30478 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263020AbREaPIO>; Thu, 31 May 2001 11:08:14 -0400
Subject: Re: Sound card lockup on 2.4.5-ac4 and -ac5
To: bentw@chello.nl (Ben Twijnstra)
Date: Thu, 31 May 2001 16:06:16 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01053115473900.00941@beastie> from "Ben Twijnstra" at May 31, 2001 03:47:39 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155U1g-0007at-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As of 2.4.5-ac4 (maybe -ac3 too), my sound card (a cs46xx) has stopped 
> working. Looks like there's something wrong with the interrupt handling code 
> because the device remains busy, I get weird lockups after having run and 

The locking fixes broke it. I'll try and take a look at it this weekend. Its
probably just a missing init_MUTEX() somewhere
