Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275291AbTHGMNp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 08:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275294AbTHGMNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 08:13:45 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:48258 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S275291AbTHGMNl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 08:13:41 -0400
Subject: Re: [RFC] new feattures to improve linux interrupt response
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Takeharu KATO <tkato@cs.fujitsu.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3F322919.AFFC7B6F@cs.fujitsu.co.jp>
References: <3F322919.AFFC7B6F@cs.fujitsu.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1060258189.3168.34.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 13:09:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-07 at 11:25, Takeharu KATO wrote:
> 	a)　Quick interruption handling facility for embedded systems
> 		We are designing and implementing quick interrupt handling facility 
> 		for embedded systems. This is achieved by accepting some 
> 		interrupts(these are pre-defined in kernel configuration.) in current 
> 		Linux kernel's critical sections. 
> 		
> 		We will modify local_irq_disable/local_irq_enable macros
> 		to keep interrupt masks of some interrupts which need to handle quickly
> 		un-masked in most of kernel critical sections.

Thats something you can do in board specific/platform specific code and
it does seem to work. I had hacks at one point doing this for the serial
port on the Macintosh II.


