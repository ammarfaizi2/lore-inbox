Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264441AbUEEVqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbUEEVqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 17:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264690AbUEEVqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 17:46:38 -0400
Received: from spc1-brig1-3-0-cust85.lond.broadband.ntl.com ([80.0.159.85]:40330
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S264441AbUEEVqf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 17:46:35 -0400
Date: Wed, 5 May 2004 22:46:34 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with nptl and uname
In-Reply-To: <c7badk$333$1@p3EE0629D.dip0.t-ipconnect.de>
Message-ID: <Pine.LNX.4.58.0405052241400.6631@ppg_penguin>
References: <c7badk$333$1@p3EE0629D.dip0.t-ipconnect.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 May 2004, Andreas Hartmann wrote:

> Hello all,
>
> I've have a problem to get ntpl working on my machine:
>

Sorry about replying to the list, but my (cable) IP address fails your
blacklist.

> I have a AMD Athlon XP and kernel 2.6.6-rc3 (2.6.6-rc3-mm1). I compiled
> glibc 2.3.3 with gcc 3.3.2, kernelheaders 2.6.5.1 and binutils
> 2.15.90.0.3 with
>
> configure --with-tls --prefix=/usr --enable-add-ons=nptl --enable-kernel=2.4.1
>

>
> initial thread stack 0x80037000-0xc0000000 (0x3ffc9000)
> /opt/cd/libc/compile/nptl/tst-attr3: pthread_create #1 failed: Cannot
> allocate memory
>

 At a guess, no tmpfs support, or it's not mounted at /dev/shm.

>
> There seems to be another problem wit uname:
>
> Hardware platform:
> uname -i
> unknown
>
> CPU:
> uname -p
> unknown
>

 Absolutely normal.  On linuxfromscratch there's a patch for coreutils
which would make uname -p return AuthenticAMD, but that's getting OT
here.

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

