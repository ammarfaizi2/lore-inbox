Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136584AbREAHYo>; Tue, 1 May 2001 03:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136583AbREAHYe>; Tue, 1 May 2001 03:24:34 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52999 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136582AbREAHY0>; Tue, 1 May 2001 03:24:26 -0400
Subject: Re: 2.2.19 locks up on SMP
To: ionut@cs.columbia.edu (Ion Badulescu)
Date: Tue, 1 May 2001 08:27:45 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andrea@suse.de (Andrea Arcangeli),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0104302141510.12259-100000@age.cs.columbia.edu> from "Ion Badulescu" at Apr 30, 2001 09:47:26 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uUZX-0001GJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think it started in 2.2.19pre10. I can reproduce the hang on pre10, 
> quite easily, but I couldn't reproduce it on pre5, pre7 and pre9. I'll try 
> a few other pre versions, just to make sure.

Ok the main candidates there would be:

	The sunrpc/nfs changes
	EEpro100/starfire
	aic7xxx

which of those drivers are you using ?

