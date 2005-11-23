Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbVKWPsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVKWPsy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbVKWPsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:48:54 -0500
Received: from [195.110.122.101] ([195.110.122.101]:19104 "EHLO
	cadalboia.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S1751066AbVKWPsx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:48:53 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Dual opteron various segfaults with 2.6.14.2 and earlier kernels
Date: Wed, 23 Nov 2005 16:49:43 +0100
User-Agent: KMail/1.9
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200511231537.49320.cova@ferrara.linux.it> <1132756861.2795.49.camel@laptopd505.fenrus.org>
In-Reply-To: <1132756861.2795.49.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511231649.44482.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 15:41, mercoledì 23 novembre 2005, Arjan van de Ven ha scritto:
> On Wed, 2005-11-23 at 15:37 +0100, Fabio Coatti wrote:
> > Hi all,
> > I'm seeing several segfaults on a couple of HP DL585 Dual Opterons, 8Gb
> > ram each.
>
> are you using the gentoo buildstuff for this? eg libjail or whatever
> it's called?

 ldd /usr/bin/sed
        libc.so.6 => /lib/libc.so.6 (0x00002aaaaabc1000)
        /lib64/ld-linux-x86-64.so.2 (0x00002aaaaaaab000)

The kernel is compiled in usual way, with vanilla sources, no distro patches.



-- 
Fabio "Cova" Coatti    http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
