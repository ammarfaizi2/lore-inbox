Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268848AbUIQRDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268848AbUIQRDo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 13:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268914AbUIQRBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 13:01:39 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:3275 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268848AbUIQRA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 13:00:59 -0400
Subject: Re: [PATCH][2.6][4/14] dvb core update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Michael Hunold <hunold@linuxtv.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0409171648270.8300@jjulnx.backbone.dif.dk>
References: <414AF2CA.3000502@linuxtv.org> <414AF31B.1090103@linuxtv.org>
	 <414AF399.3030708@linuxtv.org> <414AF41A.6060009@linuxtv.org>
	 <414AF461.4050707@linuxtv.org>
	 <Pine.LNX.4.61.0409171648270.8300@jjulnx.backbone.dif.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095436702.26086.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 17 Sep 2004 16:58:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-17 at 15:58, Jesper Juhl wrote:
> And I'll bet there are probably more if I could be bothered to check the 
> actual files.

Lots of drivers use C++^WBCPL comments  (C++ just borrowed them)

> Besides, didn't C99 make C++ style comments valid for C code as well?  

Yes and this leads to such fun as

	x = 4 //**/
		-1;

	if(x == 3)
		printf("New C compiler\n");


