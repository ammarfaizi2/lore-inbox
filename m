Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270853AbRHNU5Y>; Tue, 14 Aug 2001 16:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270843AbRHNU5N>; Tue, 14 Aug 2001 16:57:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21765 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270855AbRHNU5E>; Tue, 14 Aug 2001 16:57:04 -0400
Subject: Re: [PATCH] CDP handler for linux
To: chrisc@shad0w.org.uk (Chris Crowther)
Date: Tue, 14 Aug 2001 21:59:02 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108142137300.3810-100000@monolith.shad0w.org.uk> from "Chris Crowther" at Aug 14, 2001 09:54:09 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WlHC-0001xF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	This said, if the consesus is that it belongs in userspace, I
> shall set about porting the code over to a dameon and possibly maintaing
> the kernel patch as a secondary "hobby project".

I really think user space is the right place for it. That keeps it in
pageable memory and likely to dump a core not an entire box on errors.

The hobby one is a nice little example of how to do the kernel net bits tho
