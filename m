Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318228AbSGaNGr>; Wed, 31 Jul 2002 09:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318234AbSGaNGr>; Wed, 31 Jul 2002 09:06:47 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:48629 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318228AbSGaNGr>; Wed, 31 Jul 2002 09:06:47 -0400
Subject: RE: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Luyer <david_luyer@pacific.net.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00c201c23892$1c5fb450$638317d2@pacific.net.au>
References: <00c201c23892$1c5fb450$638317d2@pacific.net.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 31 Jul 2002 15:26:39 +0100
Message-Id: <1028125599.7886.68.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-31 at 13:59, David Luyer wrote:
>   printf("%d\n", sysconf(_SC_NPROCESSORS_CONF));
> }
> luyer@praxis8:~$ ./cpus
> 4
> luyer@praxis8:~$ grep 'processor        ' /proc/cpuinfo
> processor       : 0
> processor       : 1

In which case I suggest you file a glibc bug. sysconf looks at the /proc
stuff as I understand it

