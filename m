Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWFQECx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWFQECx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 00:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWFQECx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 00:02:53 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:24580 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751330AbWFQECw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 00:02:52 -0400
Date: Sat, 17 Jun 2006 12:02:30 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Dave Jones <davej@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AGPGART: unable to get memory for graphics translation table.
In-Reply-To: <20060617034633.GC2893@redhat.com>
Message-ID: <Pine.LNX.4.64.0606171201280.2812@raven.themaw.net>
References: <Pine.LNX.4.64.0606171125390.2748@raven.themaw.net>
 <20060617034633.GC2893@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-2.599,
	required 5, autolearn=not spam, BAYES_00 -2.60)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006, Dave Jones wrote:

> On Sat, Jun 17, 2006 at 11:32:24AM +0800, Ian Kent wrote:
>  > 
>  > Hi all,
>  > 
>  > I've been having trouble with my Radeon card not working with X.
>  > 
>  > 01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AS [Radeon 
>  > 9550]
>  > 
>  > The only thing I can find that may be a clue is:
>  > 
>  > Jun 17 11:12:48 raven kernel: agpgart: Detected AGP bridge 0
>  > Jun 17 11:12:48 raven kernel: agpgart: unable to get memory for graphics 
>  > translation table.
>  > Jun 17 11:12:48 raven kernel: agpgart: agp_backend_initialize() failed.
>  > Jun 17 11:12:48 raven kernel: agpgart-amd64: probe of 0000:00:00.0 failed 
>  > with error -12
>  
> Is this with the free Xorg drivers, or the ATI fglx thing ?
> I don't think I've ever seen agp_generic_create_gatt_table() fail before,
> and that hasn't changed for a looong time.

xorg driver yep.

Works fine on FC5 kernels ??

Ian

