Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130287AbQLEWtG>; Tue, 5 Dec 2000 17:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130783AbQLEWs4>; Tue, 5 Dec 2000 17:48:56 -0500
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:47117 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S130287AbQLEWsm>; Tue, 5 Dec 2000 17:48:42 -0500
Date: Tue, 5 Dec 2000 15:18:13 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: 2.2.18pre24 - forgotten symbols
Message-ID: <20001205151813.A1062@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With an SMP kernel one gets, in particular,

depmod: *** Unresolved symbols in /lib/modules/2.2.18pre24/misc/agpgart.o
depmod:         smp_call_function
depmod:         smp_num_cpus

The machine affected is actually Alpha but likely this is not relevant.

   Michal
   michal@harddata.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
