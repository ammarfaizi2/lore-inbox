Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbUL0T5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbUL0T5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 14:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUL0T5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 14:57:05 -0500
Received: from serwer.tvgawex.pl ([212.122.214.2]:1028 "HELO
	pa13.bydgoszcz.sdi.tpnet.pl") by vger.kernel.org with SMTP
	id S261956AbUL0Tze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 14:55:34 -0500
Subject: Re: Module Names - Hyphen Converted to Underscore
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
In-Reply-To: <41D064D0.6050509@transtec.demon.co.uk>
References: <41D064D0.6050509@transtec.demon.co.uk>
Content-Type: text/plain; charset=iso-8859-2
Date: Mon, 27 Dec 2004 20:54:42 +0100
Message-Id: <1104177282.5683.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia 27-12-2004, pon o godzinie 19:38 +0000, AJM napisa³(a):
> I have compiled stock (kernel.org) 2.6.3 and 2.6.9 kernels which exhibit 
> the following unusual behaviour on module loading: If the kernel module 
> has a hyphen in its name, then this appears to be translated into an 
> underscore by the kernel, such that, for example after "insmod 3w-xxxx", 
> lsmod shows "3w_xxxx", "rmmod 3w-xxxx" fails but "rmmod 3w_xxxx" succeeds.

> Any suggestions as to why this is happening?

 That convenience thing, look at man modprobe:

 modprobe intelligently adds or removes a module from the Linux kernel:
note  that  for  convenience,there  is  no  difference  between  _  and
- in module names. 


-- 
Tomasz Torcz
zdzichu@irc.-spam.nie-.pl

