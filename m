Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274134AbRJBOID>; Tue, 2 Oct 2001 10:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274196AbRJBOHx>; Tue, 2 Oct 2001 10:07:53 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19719 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274134AbRJBOHh>; Tue, 2 Oct 2001 10:07:37 -0400
Subject: Re: 2.4.11-ac3 -- unresolved symbols in cramfs.o --
To: miles@megapathdsl.net (Miles Lane)
Date: Tue, 2 Oct 2001 15:13:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <1001998604.8562.4.camel@stomata.megapathdsl.net> from "Miles Lane" at Oct 01, 2001 09:56:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oQIF-0004nT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This problem is still present in 2.4.11-ac3.
> 
> > Frank Davis <fdavis@si.rr.com> wrote:
> > 
> > Hello all,
> >     I received the following while 'make modules_install'
> > depmod: *** Unresolved symbols in 
> > /lib/modules/2.4.9-ac17/kernel/fs/cramfs/cramfs/cramfs.o
> > depmod:  zlib_fs_inflateInit_
> > depmod:  zlib_fs_inflateEnd

In what circumstances do you get this . I do cross chekx the -ac trees
for module symbol problems so Im curious what config is triggering it.

Right now I can only trigger a couple of acpi module ones

Alan
