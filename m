Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270804AbTHOTjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 15:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270806AbTHOTjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 15:39:05 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:65029 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S270804AbTHOTjD
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Fri, 15 Aug 2003 15:39:03 -0400
Message-Id: <200308151944.h7FJiuIW003574@ccure.karaya.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Nikita Danilov <Nikita@Namesys.COM>
cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Oleg Drokin <Green@Namesys.COM>
Subject: Re: [PATCH]: fix kobject initialization in drivers/char/tty_io.c 
In-Reply-To: Your message of "Fri, 06 Jun 2003 21:07:35 +0400."
             <16096.51799.485147.930465@laputa.namesys.com> 
References: <16096.51799.485147.930465@laputa.namesys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Aug 2003 15:44:56 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita@Namesys.COM said:
> in 2.5.70, UML fails to boot with
> Initializing stdio console driver Badness in kobject_get at lib/
> kobject.c:351 

I haven't seen this lately, so I'm guessing the ordering problem was fixed
when the console initcall stuff was added.

				Jeff

