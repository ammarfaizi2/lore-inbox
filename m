Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281738AbRLLSSL>; Wed, 12 Dec 2001 13:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281748AbRLLSRw>; Wed, 12 Dec 2001 13:17:52 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:6669 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S281738AbRLLSRm>; Wed, 12 Dec 2001 13:17:42 -0500
Date: Wed, 12 Dec 2001 10:19:49 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Near CPUs ...
In-Reply-To: <E16E9x9-00019X-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0112121018540.1564-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001, Alan Cox wrote:

> > that lists metrics between CPUs, ie :
> >
> > metric(I, J) = F(cpus_dmap[I][J])
> >
> > and this is the easy part.
> > How to detect CPUs that are "near" ( on the same bus/mb ) on x86/ia64 hardware ?
> > Is the MP configuration data structured in a way that makes you understand
> > this mapping, ie :
>
> The MP 1.1/1.4 mappings have no information on memory or locality. The ACPI
> stuff seems to have the same limitations. The ACPI one does correctly
> describe hyperthreading pairs (two execution units per die) - but while they
> are "closer" they are also less efficient than two seperate cpus for most
> tasks.

Don't we need a common abstract interface to describe this topology
informations ?




- Davide


