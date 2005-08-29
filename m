Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbVH2PG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbVH2PG2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 11:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVH2PG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 11:06:28 -0400
Received: from smtp102.biz.mail.mud.yahoo.com ([68.142.200.237]:8053 "HELO
	smtp102.biz.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751030AbVH2PG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 11:06:27 -0400
Subject: Re: [PATCH 2/3] exterminate strtok - drivers/video/au1100fb.c
From: Pete Popov <ppopov@mvista.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490508290800bba68c1@mail.gmail.com>
References: <200508242108.32885.jesper.juhl@gmail.com>
	 <1124950581.14435.978.camel@localhost.localdomain>
	 <9a8748490508290443ab7cd62@mail.gmail.com>
	 <1125326968.6104.4.camel@localhost.localdomain>
	 <9a8748490508290800bba68c1@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 29 Aug 2005 08:06:14 -0700
Message-Id: <1125327974.6104.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then I must be blind, because I still see the old strtok() using code
> in there :

You must be looking at kernel.org. I'm talking about linux-mips.  Any
linux mips patches should go through linux-mips.org and Ralf eventually
gets them into kernel.org.

Pete

> juhl@dragon:~/download/kernel/linux-2.6.13$ head -n 5 Makefile
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 13
> EXTRAVERSION =
> NAME=Woozy Numbat
> juhl@dragon:~/download/kernel/linux-2.6.13$ grep -A 1 strtok
> drivers/video/au1100fb.c
>         for(this_opt=strtok(options, ","); this_opt;
>             this_opt=strtok(NULL, ",")) {
>                 if (!strncmp(this_opt, "panel:", 6)) {
> 
> And the patch I created still applies just fine.
> 
> 

