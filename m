Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbTDDIAm (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 03:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263469AbTDDIAm (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 03:00:42 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:49162 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S263458AbTDDIAf (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 03:00:35 -0500
Message-Id: <200304040802.h3482Zu20691@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Dave Jones <davej@codemonkey.org.uk>,
       Fendrakyn <fendrakyn@europaguild.com>
Subject: Re: [BUG] E7x05 chipset bug in 2.5 kernels' AGPGART driver.
Date: Fri, 4 Apr 2003 09:58:08 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200304022050.03026.fendrakyn@europaguild.com> <20030402221046.GA30881@suse.de>
In-Reply-To: <20030402221046.GA30881@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 April 2003 00:10, Dave Jones wrote:
> On Wed, Apr 02, 2003 at 08:50:03PM +0200, Fendrakyn wrote:
>  > There is a mistake in the Makefile of drivers/char/agp, the line
>  > concerning i7x05-agp support does not match the one in the
>  > Kconfig, thus e7x05 support is never compiled, be it as a module
>  > or in the kernel.
>
> I'm really amazed. This has been broken for months, and no-one
> noticed. The day I fixed it in the agpgart bk tree, I got a half
> dozen reports, and now I'm getting one daily. Truly bizarre.

Jargon file have an entry about class of bugs which
are latent (do not bite anybody) until discovered.
When discovered, relevant pieces of code promptly stop working.

I thought that was a joke ;)
--
vda
