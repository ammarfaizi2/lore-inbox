Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130526AbQLOSb2>; Fri, 15 Dec 2000 13:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130519AbQLOSbS>; Fri, 15 Dec 2000 13:31:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:37769 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130131AbQLOSbE>;
	Fri, 15 Dec 2000 13:31:04 -0500
Date: Fri, 15 Dec 2000 09:44:28 -0800
Message-Id: <200012151744.JAA21052@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: andrea@suse.de
CC: ink@jurassic.park.msu.ru, ezolt@perf.zko.dec.com, axp-list@redhat.com,
        rth@twiddle.net, Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, clinux@zk3.dec.com,
        wcarr@perf.zko.dec.com, linux-alpha@vger.kernel.org
In-Reply-To: <20001215185528.C17781@inspiron.random> (message from Andrea
	Arcangeli on Fri, 15 Dec 2000 18:55:28 +0100)
Subject: Re: mm->context[NR_CPUS] and pci fix check [was Re: Alpha SCSI error on 2.4.0-test11]
In-Reply-To: <20001201004049.A980@jurassic.park.msu.ru> <Pine.OSF.3.96.1001130171941.32335D-100000@perf.zko.dec.com> <20001130233742.A21823@athlon.random> <20001201145619.A553@jurassic.park.msu.ru> <20001201151842.C30653@athlon.random> <200012011819.KAA02951@pizda.ninka.net> <20001201201444.A2098@inspiron.random> <20001215164626.C16586@inspiron.random> <200012151711.JAA20826@pizda.ninka.net> <20001215185528.C17781@inspiron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 15 Dec 2000 18:55:28 +0100
   From: Andrea Arcangeli <andrea@suse.de>

   I'm aware this way all ports actively using `mm->context' needs to
   be changed but the change is certainly a no-brainer... OK?

My problem is that I don't want to typedef it to a structure, this
will unnecessarily increase the required alignment of the structure
member on some architectures.

Well, if you're willing to do all the fixing up, then I won't argue it
much more. :-)

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
