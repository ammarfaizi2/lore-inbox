Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293508AbSBZEaC>; Mon, 25 Feb 2002 23:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293509AbSBZE3x>; Mon, 25 Feb 2002 23:29:53 -0500
Received: from goose.mail.pas.earthlink.net ([207.217.120.18]:47351 "EHLO
	goose.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S293508AbSBZE3i>; Mon, 25 Feb 2002 23:29:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Randy Hron <rwhron@earthlink.net>
To: "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.18-rc4-jam2
Date: Mon, 25 Feb 2002 23:33:59 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020225020725.A1674@werewolf.able.es>
In-Reply-To: <20020225020725.A1674@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16fZEv-0002C5-00@goose.prod.itd.earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 24 Feb 02 20:07, J.A. Magallon wrote:
> 
> After one other session of patch messing, here is rc4-jam2. Main update
> is vm-25 -> vm-27 from Andrea. Get it as usual at:
> 
> http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.18-rc4-jam2/

Some recent jam patchsets next to -aa at:
http://home.earthlink.net/~rwhron/kernel/jam.html

There is a lot of common code in the kernels tested, but there are
a few notables:
-aa about 30% faster on the Open Source Database Benchmark
-aa 10-20% faster on tests involving lots of forks.
-jams about 15% faster on tbench
Lots of variation in tiobench.

The tiobench numbers are the most intriguing.  
Hoping someone can make sense of them.
