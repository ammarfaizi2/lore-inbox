Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWFQKa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWFQKa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 06:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbWFQKa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 06:30:27 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:30980 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751446AbWFQKa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 06:30:27 -0400
Date: Sat, 17 Jun 2006 18:29:20 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Dave Jones <davej@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AGPGART: unable to get memory for graphics translation table.
In-Reply-To: <20060617054307.GB8328@redhat.com>
Message-ID: <Pine.LNX.4.64.0606171827150.2564@raven.themaw.net>
References: <Pine.LNX.4.64.0606171125390.2748@raven.themaw.net>
 <20060617034633.GC2893@redhat.com> <Pine.LNX.4.64.0606171201280.2812@raven.themaw.net>
 <20060617044625.GA8328@redhat.com> <Pine.LNX.4.64.0606171315220.2812@raven.themaw.net>
 <Pine.LNX.4.64.0606171323100.2433@raven.themaw.net> <20060617054307.GB8328@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-2.599,
	required 5, autolearn=not spam, BAYES_00 -2.60)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006, Dave Jones wrote:

> On Sat, Jun 17, 2006 at 01:24:58PM +0800, Ian Kent wrote:
> 
>  > Linux raven.themaw.net 2.6.16-1.2289_FC6xen #1 SMP Thu Jun 15 14:48:53 EDT 
>                                            ^^^
> 
> I'll bet xen is to blame.  Can you try it on a plain kernel.org kernel?

I tell a lie.

Standard kernel now works.
All I noticed between the dmesg files was that the init of the agpgart is 
somewhat later with the xen kernel.

Ian

