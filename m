Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSJMSor>; Sun, 13 Oct 2002 14:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261575AbSJMSor>; Sun, 13 Oct 2002 14:44:47 -0400
Received: from fungus.teststation.com ([212.32.186.211]:47879 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S261568AbSJMSoq>; Sun, 13 Oct 2002 14:44:46 -0400
Date: Sun, 13 Oct 2002 20:49:37 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Henrik =?iso-8859-1?Q?St=F8rner?= <henrik@hswn.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.42 breaks Soundblaster OSS driver and smbfs modules
In-Reply-To: <20021013154435.GA25380@hswn.dk>
Message-ID: <Pine.LNX.4.44.0210132029310.23052-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, Henrik Størner wrote:

> Yes, I still have an old SB16 ISA card in my machine. Works
> fine i 2.5.41, but with 2.5.42 I get this:
> 
> osiris:~ $ sudo /sbin/depmod -ae
> depmod: *** Unresolved symbols in /lib/modules/2.5.42/kernel/fs/smbfs/smbfs.o
> depmod:         do_schedule

My local 2.5.42 tree doesn't have any references to do_schedule at all.
Any funny patches?

/Urban

