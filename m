Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313807AbSDPSOR>; Tue, 16 Apr 2002 14:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313808AbSDPSOQ>; Tue, 16 Apr 2002 14:14:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47367 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313807AbSDPSOP>; Tue, 16 Apr 2002 14:14:15 -0400
Subject: Re: MODULE_LICENSE string for LGPL drivers?
To: jenglish@flightlab.com (Joe English)
Date: Tue, 16 Apr 2002 19:31:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200204161800.g3GI06f22193@dragon.flightlab.com> from "Joe English" at Apr 16, 2002 11:00:06 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xXk5-0000Zo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What should I use for the MODULE_LICENSE() string in a driver
> that is distributed under the LGPL?  "LGPL" isn't listed in
> include/linux/module.h as an "untainted" license, so should I

When LGPL code is linked with GPL code then the result becomes GPL. So
once you have the code combined with the kernel it is GPL unless its
a seperate work.

Alan
