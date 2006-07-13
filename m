Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWGMLZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWGMLZw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 07:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWGMLZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 07:25:52 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47778 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932177AbWGMLZv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 07:25:51 -0400
Subject: Re: Athlon64 + Nforce4 MCE panic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rumi Szabolcs <rumi_ml@rtfm.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060713090146.690d4759.rumi_ml@rtfm.hu>
References: <20060713090146.690d4759.rumi_ml@rtfm.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Jul 2006 12:44:05 +0100
Message-Id: <1152791045.5511.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-07-13 am 09:01 +0200, ysgrifennodd Rumi Szabolcs:
> # echo 'CPU 0: Machine Check Exception: 0000000000000004 Bank 4: b200000000070f0f' | mcelog --ascii --k8
> HARDWARE ERROR. This is *NOT* a software problem!
> Please contact your hardware vendor

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


It prints this bit for a reason

MCE almost always occurs because your processor detected an internal
inconsistency, in this case a parity error. So you almost certainly have
a real hardware problem.

Fixing it tends to depend on the system. With bigger servers you usually
find that the MCE info produces the correct response because the server
people actually understand use and care about MCEs even in other-os.

For random cheap desktop PC systems it can be more fun, reporting an MCE
is as likely to cause them to send you a new monitor as any other part
unfortunately 8)


