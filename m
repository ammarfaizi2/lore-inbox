Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262185AbREQVZq>; Thu, 17 May 2001 17:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262184AbREQVZg>; Thu, 17 May 2001 17:25:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38150 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262185AbREQVZY>; Thu, 17 May 2001 17:25:24 -0400
Subject: Re: [PATCH] 2.4.5pre3 warning fixes
To: Sam.Bingner@hickam.af.mil (Bingner Sam J. Contractor RSIS)
Date: Thu, 17 May 2001 22:21:46 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), richbaum@acm.org,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <4CDA8A6D03EFD411A1D300D0B7E83E8F697326@FSKNMD07.hickam.af.mil> from "Bingner Sam J. Contractor RSIS" at May 17, 2001 07:49:05 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150VDO-00069w-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if (c->devices != NULL){
> 	c->devices->prev=d;
> }
> 
> I assume the new compiler likes the if to have explicit brackets instead of
> using the next statement...

Then its not a C compiler
