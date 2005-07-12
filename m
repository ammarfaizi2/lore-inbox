Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVGLG5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVGLG5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 02:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVGLG5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 02:57:18 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:52145 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261212AbVGLG4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 02:56:17 -0400
Subject: Re: [PATCH] [44/48] Suspend2 2.1.9.8 for 2.6.12: 620-userui.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050710182214.GJ10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <1120616444451@foobar.com>
	 <20050710182214.GJ10904@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121151481.13869.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 16:58:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, 2005-07-11 at 04:22, Pavel Machek wrote:
> On St 06-07-05 12:20:44, Nigel Cunningham wrote:
> > diff -ruNp 621-swsusp-tidy.patch-old/kernel/power/swsusp.c 621-swsusp-tidy.patch-new/kernel/power/swsusp.c
> > --- 621-swsusp-tidy.patch-old/kernel/power/swsusp.c	2005-06-20 11:47:31.000000000 +1000
> > +++ 621-swsusp-tidy.patch-new/kernel/power/swsusp.c	2005-07-04 23:14:19.000000000 +1000
> > @@ -36,6 +36,8 @@
> >   * For TODOs,FIXMEs also look in Documentation/power/swsusp.txt
> >   */
> >  
> > +#define KERNEL_POWER_SWSUSP_C
> 
> Headers that change depending on #define's are considered evil......

Fixed. Thanks!

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

