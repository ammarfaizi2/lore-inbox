Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289694AbSAPMMs>; Wed, 16 Jan 2002 07:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290432AbSAPMMi>; Wed, 16 Jan 2002 07:12:38 -0500
Received: from coruscant.franken.de ([193.174.159.226]:15810 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S289694AbSAPMM3>; Wed, 16 Jan 2002 07:12:29 -0500
Date: Wed, 16 Jan 2002 13:03:17 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Luca Adesso <ladesso@libero.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: iptables and 2.4.17
Message-ID: <20020116130317.H30850@sunbeam.de.gnumonks.org>
In-Reply-To: <5.1.0.14.0.20020116115713.00a96ec0@popmail.libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <5.1.0.14.0.20020116115713.00a96ec0@popmail.libero.it>; from ladesso@libero.it on Wed, Jan 16, 2002 at 12:13:11PM +0100
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Setting Orange, the 15th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 12:13:11PM +0100, Luca Adesso wrote:
> There is some problem with iptables modules and kernel 2.4.17 ?
> I'm using 2.4.10 and it works fine; I tried on another computer at work the 
> 2.4.17 but I got unresolved symbol errors
> ip_tables.o: unresolved symbol nf_unregister_sockopt
> ip_tables.o: unresolved symbol nf_register_sockopt

Strange. Are you sure you really did it in the following order:

make clean (better: make mrproper)
- configure the kernel
make bzImage
- install your new bzImage
make modules
make modules_install
- boot into your new kernel

We haven't had any bug report regarding your problem, and I'm personally 
also running plain 2.4.17 on one of my boxes without any problems.

> Thanks.

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
