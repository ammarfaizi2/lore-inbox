Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270626AbRHJAVW>; Thu, 9 Aug 2001 20:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270627AbRHJAVN>; Thu, 9 Aug 2001 20:21:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58635 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270626AbRHJAUz>; Thu, 9 Aug 2001 20:20:55 -0400
Subject: Re: esssound.o once more
To: johnpol@2ka.mipt.ru
Date: Fri, 10 Aug 2001 01:22:46 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Evgeny Polyakov" at Aug 10, 2001 04:08:35 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15V04c-0008Tx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is messages, that was occured while 2.4.7-ac9 was compiling:
> drivers/sound/sounddrivers.o: In function `solo1_update_ptr':
> drivers/sound/sounddrivers.o(.text+0xd6e): undefined reference to `clear_advance'
> drivers/sound/sounddrivers.o: In function `solo1_write':

Don't compile with gcc 3.0 and it should be fine. Alternatively swap the
extern inline for static inline
