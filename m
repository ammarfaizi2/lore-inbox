Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266525AbUGPLUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266525AbUGPLUb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 07:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266528AbUGPLUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 07:20:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:56710 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266525AbUGPLU2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 07:20:28 -0400
Date: Fri, 16 Jul 2004 07:19:42 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stuart Young <cef-lkml@optusnet.com.au>
cc: linux-kernel@vger.kernel.org,
       Markus Lidel <Markus.Lidel@shadowconnect.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
In-Reply-To: <200406031241.27669.cef-lkml@optusnet.com.au>
Message-ID: <Pine.LNX.4.53.0407160715210.21606@chaos>
References: <40BC788A.3020103@shadowconnect.com> <40BDF1AC.7070209@shadowconnect.com>
 <Pine.LNX.4.53.0406021144280.559@chaos> <200406031241.27669.cef-lkml@optusnet.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2004, Stuart Young wrote:

> On Thu, 3 Jun 2004 01:45, Richard B. Johnson wrote:
> > I asked for the output of `cat /proc/pci` . Unless I get that
> > information, I can't find the length of the allocation.
>
> Is there no way to to get this information out of lspci (eg: lspci -vv)? This
> is particularly annoying since /proc/pci is depreciated. I know a number of
> people who simply don't bother turning it on anymore. If there is information
> in /proc/pci that isn't available through lspci somehow, then I'd call that a
> nasty regression, which needs to be fixed.
>
> Are you sure on this Richard? (No disrespect intended, just want to confirm
> things).
>

I didn't say what I was 're-quoted'. That's from somebody else.
If they are taking away /proc/pci (sniff), you need to use
`lspci -v` to get the length . If they are taking that way,
you need to make your own!


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


