Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275890AbSIUKAJ>; Sat, 21 Sep 2002 06:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275891AbSIUKAI>; Sat, 21 Sep 2002 06:00:08 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:34061 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S275890AbSIUKAI>; Sat, 21 Sep 2002 06:00:08 -0400
Date: Sat, 21 Sep 2002 12:05:29 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
To: Steven Cole <elenstev@mesatop.com>
Cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.37 lockup with dbench 36 and make -j3 bzImage and PREEMPT=y.
Message-ID: <20020921120529.A20153@hh.idb.hist.no>
References: <1032555932.14946.225.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1032555932.14946.225.camel@spc9.esa.lanl.gov>; from elenstev@mesatop.com on Fri, Sep 20, 2002 at 23:05:32 +0200
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002.09.20 23:05 Steven Cole wrote:
> While running 2.5.37 with 36 dbench clients and doing a kernel compile
> with make -j3 bzImage, my test machine locked up.  

2.5.36 SMP no preempt locks up under similiar circumstances - a compile
with make -j 3 and moderate disk activity on 2 scsi disks makes it
freeze solid now and then.  Perhaps this is some sort of SMP problem
also exposed by preempt?

I haven't tested this in 2.5.37 because refuses to run X.

Helge Hafting
