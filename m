Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261927AbTCQTtz>; Mon, 17 Mar 2003 14:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261930AbTCQTtz>; Mon, 17 Mar 2003 14:49:55 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:52193 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261927AbTCQTty>; Mon, 17 Mar 2003 14:49:54 -0500
Date: Mon, 17 Mar 2003 15:00:41 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200303172000.h2HK0fb07154@devserv.devel.redhat.com>
To: Heinz Ulrich Stille <hus@design-d.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Read Hat 7.3 and 8.0 compilation problems
In-Reply-To: <mailman.1047904680.20757.linux-kernel2news@redhat.com>
References: <001d01c2ec83$6bfbcc10$e9bba5cc@patni.com> <mailman.1047904680.20757.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you using the stock rh kernel sources? Did you install the
> glibc-kernheaders RPM? This contains severe RedHat braindamage:
> /usr/include/{asm,linux} aren't links into the kernel source tree,
> but directly installed. Remove the rpm and create the soft links
> to /usr/src/linux.
> 
> MfG, Ulrich

I resent this. It was explained 1000 times before
that /usr/include/{asm,linux} belong to glibc, not kernel.
Replacing these links with pointers to an updated kernel
will produce applications which mismatch the installed glibc,
and then mysteriously fail to work. Heinz-Ulrich can call names
all he wants, but the truth does not change.

-- Pete
