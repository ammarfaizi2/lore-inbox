Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273748AbRJIIvg>; Tue, 9 Oct 2001 04:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273787AbRJIIvb>; Tue, 9 Oct 2001 04:51:31 -0400
Received: from web11801.mail.yahoo.com ([216.136.172.155]:38161 "HELO
	web11801.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S273748AbRJIIvK>; Tue, 9 Oct 2001 04:51:10 -0400
Message-ID: <20011009085140.85739.qmail@web11801.mail.yahoo.com>
Date: Tue, 9 Oct 2001 10:51:40 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: [PATCH] change name of rep_nop
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,
> 	__asm__ __volatile__("rep;nop");

"The behavior of the REP prefix is undefined when used with non-string
instructions." page 3-404 of Intel documentation, in "CHAPTER 3,
INSTRUCTION SET REFERENCE"...

  How about: __asm__ __volatile__("loop ." : "+c" (nbloop)); ?

  Etienne.

___________________________________________________________
Un nouveau Nokia Game commence. 
Allez sur http://fr.yahoo.com/nokiagame avant le 3 novembre
pour participer à cette aventure tous médias.
