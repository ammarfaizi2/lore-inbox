Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263358AbTCNPWd>; Fri, 14 Mar 2003 10:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263360AbTCNPWd>; Fri, 14 Mar 2003 10:22:33 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:2372 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263358AbTCNPWc>; Fri, 14 Mar 2003 10:22:32 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303141532.h2EFWIa24465@devserv.devel.redhat.com>
Subject: Re: 2.5.64-ac4: mpparse.c doesn't compile
To: bunk@fs.tum.de (Adrian Bunk)
Date: Fri, 14 Mar 2003 10:32:18 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org,
       tomita@cinet.co.jp (Osamu Tomita)
In-Reply-To: <20030314153107.GT16212@fs.tum.de> from "Adrian Bunk" at Mar 14, 2003 04:31:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> arch/i386/kernel/mpparse.c: In function `get_smp_config':
> arch/i386/kernel/mpparse.c:658: `pc98' undeclared (first use in this function)
> arch/i386/kernel/mpparse.c:658: (Each undeclared identifier is reported only once
> arch/i386/kernel/mpparse.c:658: for each function it appears in.)
> make[1]: *** [arch/i386/kernel/mpparse.o] Error 1

For the moment build uniprocessor or make that "pc98" => 0
