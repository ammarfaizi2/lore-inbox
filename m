Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272554AbTHKN3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272562AbTHKN3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:29:52 -0400
Received: from hulotte.CC.UMontreal.CA ([132.204.2.135]:32949 "EHLO
	hulotte.cc.umontreal.ca") by vger.kernel.org with ESMTP
	id S272554AbTHKN3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:29:50 -0400
Date: Mon, 11 Aug 2003 09:29:28 -0400
From: Xiaogang Wang <xiaogang.wang@umontreal.ca>
X-X-Sender: wangx@esirch2.ESI.UMontreal.CA
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: page_alloc.c bug and heavy I/O
In-Reply-To: <Pine.LNX.4.53.0308081052420.30770@montezuma.mastecende.com>
Message-ID: <Pine.SGI.4.44.0308110922330.126655-100000@esirch2.ESI.UMontreal.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Aug 2003, Zwane Mwaikambo wrote:

> On Fri, 8 Aug 2003, Xiaogang Wang wrote:
>
> > Hi,
> >
> > My hardware and softare:
> >
> >   Asus P4P800, 2GB memory, 2.8GHZ P4 with HT enabled.
> >   On-board 3com Giga bit network card
> >   1 parallel ata 160G maxtor disk
> >   Nvidia Gefore4 MX440-8x graphics card (Asus V9180)
> >
> >   Redhat 7.3, original kernel 2.4.18-3
>
> You might want to update your RedHat kernel and if the problem persists
> report it on their bugzilla (bugzilla.redhat.com).
>

I have updated the kernel from linux-2.4.18-3 to  linux-2.4.20-19.7
with no network driver 3c2000.o compiled and with an old pci ATI rage graphics
card.

The kernel BUG occurs now at vmscan.c, in lieu of page_alloc.c


Aug  9 20:38:19 coulson kernel: ------------[ cut here ]------------
Aug  9 20:38:19 coulson kernel: kernel BUG at vmscan.c:747!
Aug  9 20:38:19 coulson kernel: invalid operand: 0000
Aug  9 20:38:19 coulson kernel:
Aug  9 20:38:19 coulson kernel: CPU:    0

I still have no clue.

Xiaogang

------------------------------------------------
Dr Xiaogang Wang
Departement de chimie
Universite de Montreal
C.P. 6128, succursale Centre-ville
Montreal (Quebec) H3C 3J7

Tel. (514) 3436111 ext 3947 (office)
FAX  (514) 3437586 (office)
e-mail: xiaogang.wang@umontreal.ca
homepage: http://www.esi.umontreal.ca/~wangx
------------------------------------------------

