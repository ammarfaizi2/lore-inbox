Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271944AbTGYHME (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 03:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271943AbTGYHME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 03:12:04 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:59660 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S271945AbTGYHMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 03:12:02 -0400
Message-Id: <200307250716.h6P7G8j05338@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: filia@softhome.net, linux-kernel@vger.kernel.org
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
Date: Fri, 25 Jul 2003 10:25:31 +0300
X-Mailer: KMail [version 1.3.2]
References: <cwQJ.3BO.29@gated-at.bofh.it> <cArg.74D.11@gated-at.bofh.it> <3F1F9531.2050204@softhome.net>
In-Reply-To: <3F1F9531.2050204@softhome.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 July 2003 11:13, Ihar \"Philips\" Filipau wrote:
>     I mean 'inline' which means 'this has to be inlined or it will 
> break' and 'inline' which means 'inline this please - it adds only 10k 
> of code bloat and improve performance in my suppa-puppa-bench by 0.000001%!'
> 
>     Strictly speaking - separate 'inline' to 'require_inline' and 
> 'better_inline'.
>     So people who really care about image size - can turn 
> 'better_inline' into void, without harm to functionality.
>     Actually I saw real performance improvements on my Pentium MMX 133 
> (it has $i16k+$d16k of caches I beleive) when I was cutting some of 
> inlines out. and I'm not talking about (cache poor) embedded systems...

Which inlines? Let the list know
--
vda
