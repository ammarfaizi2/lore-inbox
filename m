Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbVFXQiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbVFXQiq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 12:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbVFXQiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 12:38:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263126AbVFXQin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 12:38:43 -0400
Date: Fri, 24 Jun 2005 09:40:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?ISO-8859-1?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
cc: Keith Owens <kaos@ocs.com.au>, Denis Vlasenko <vda@ilport.com.ua>,
       Jeff Garzik <jgarzik@pobox.com>,
       David Lang <david.lang@digitalinsight.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: [git patch] urgent e1000 fix 
In-Reply-To: <Pine.BSO.4.62.0506241140280.19853@rudy.mif.pg.gda.pl>
Message-ID: <Pine.LNX.4.58.0506240938210.11175@ppc970.osdl.org>
References: <13661.1119601379@kao2.melbourne.sgi.com>
 <Pine.LNX.4.58.0506240149440.11175@ppc970.osdl.org>
 <Pine.BSO.4.62.0506241140280.19853@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Jun 2005, Tomasz K³oczko wrote:
> 
> Linus .. why for kernel tree can't be used indent or other source 
> code formater ?

Sure, we do it, but then we try to make it obvious to all sides.

It's the "small and non-obvious" differences that are really poisonous. 
You don't see them in the soruces, yet patches don't apply.

So don't do subtle whitespace "fixups" by default. It just makes everybody
unhappy down the line.

That's not to say that we don't do whitespace fixups _occasionally_. When 
it's ugly enough to be noticeable, I sure as hell fix up whitespace. But 
not by default.

		Linus
