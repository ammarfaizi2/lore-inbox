Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313023AbSDCCmo>; Tue, 2 Apr 2002 21:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313018AbSDCCme>; Tue, 2 Apr 2002 21:42:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64783 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313017AbSDCCmZ>; Tue, 2 Apr 2002 21:42:25 -0500
Subject: Re: Update on Promise 100TX2 + Serverworks IDE issues -- 2.2.20
To: jeff@aslab.com (Jeff Nguyen)
Date: Wed, 3 Apr 2002 03:58:41 +0100 (BST)
Cc: xyzzy@speakeasy.org (Trent Piepho), alan@lxorguk.ukuu.org.uk (Alan Cox),
        jim@rubylane.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
In-Reply-To: <15b401c1dab4$7bf2c240$6502a8c0@jeff> from "Jeff Nguyen" at Apr 02, 2002 06:08:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16sayv-00033A-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> devices are the problem maker on OSB4. Unless DMA is disabled, the system
> will lock up when accessing the drive.
> 
> If you have UDMA33 ATAPI devices, they work great in OSB4.

Except when they don't. There are definite problems with some specific
combinations and ones I know are not one offs because we've seen them over
an entire render farm for example.

The current driver panics and asks people to email me if it spots the UDMA
disk corruption about to occur pattern. I get little mail but some
