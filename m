Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263427AbRFAJOz>; Fri, 1 Jun 2001 05:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263428AbRFAJOq>; Fri, 1 Jun 2001 05:14:46 -0400
Received: from Backfire.WH8.TU-Dresden.De ([141.30.225.118]:32640 "EHLO
	Backfire.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S263427AbRFAJOb>; Fri, 1 Jun 2001 05:14:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gregor Jasny <gjasny@wh8.tu-dresden.de>
Organization: Netzwerkadministrator WH8/DD
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: 2.4.4 Kernel Oops and ls+rm segfaults
Date: Fri, 1 Jun 2001 11:14:28 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0106010451060.20420-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0106010451060.20420-100000@weyl.math.psu.edu>
X-PGP-fingerprint: B0FA 69E5 D8AC 02B3 BAEF  E307 BD3A E495 93DD A233
X-PGP-public-key: finger gjasny@hell.wh8.tu-dresden.de
MIME-Version: 1.0
Message-Id: <01060111142800.00919@backfire>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag,  1. Juni 2001 10:52 schrieb Alexander Viro:
> On Fri, 1 Jun 2001, Gregor Jasny wrote:
> > Can anyone tell me, where this oops came from?
> > The machine is a HP NetServer II lc (EISA+PCI architecture).
> > The distribution is a slackware 7.0 with parts of 7.1 and current.
> > gcc: 2.95.4 20010319 (Debian prerelease)
> >
>
> Pagecache corruption somewhere.
> 	a) what filesystems do you have?
> 	b) is the thing reproducable?
a) pure ext2-fs (sometimes a mounted nfs)
b) Not really. It happend with earlier kernel revisions, too.

I alredy replaced the fs-utils and compiled the kernel at my workstation 
(with gcc-2.95.3)

If it matters: we have the Compushack FDDI driver installed. It can be found 
at: http://hell.wh8.tu-dresden.de/~gjadm/csfddi-3.0.0-5.diff.gz

Regards,
-Gregor
