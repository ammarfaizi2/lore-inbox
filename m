Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270134AbRHWN2l>; Thu, 23 Aug 2001 09:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272260AbRHWN2b>; Thu, 23 Aug 2001 09:28:31 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65030 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270134AbRHWN2X>; Thu, 23 Aug 2001 09:28:23 -0400
Subject: Re: [PATCH (URL), RFC] Stackable dmi_blacklist rules
To: rl@hellgate.ch (Roger Luethi)
Date: Thu, 23 Aug 2001 14:31:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010823152200.A853@tm.hellgate.ch> from "Roger Luethi" at Aug 23, 2001 03:22:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Zua2-0003sM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Currently, we walk the list and throw out bad apples based on full
> or partial strings we match against what we get from the BIOS.
> Once a rule matches, the value is immutable.

Hardly. You can set it back, you can also access the fields to make 
complex decisions after a match call. 

