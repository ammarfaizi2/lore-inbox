Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130392AbRCIAyF>; Thu, 8 Mar 2001 19:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130399AbRCIAx4>; Thu, 8 Mar 2001 19:53:56 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39952 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130392AbRCIAxk>; Thu, 8 Mar 2001 19:53:40 -0500
Subject: Re: kernel 2.4.2-ac14 in vmware - hangs
To: mpanetta@applianceware.com (Mike Panetta)
Date: Fri, 9 Mar 2001 00:56:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010308164112.A26411@tetsuo.applianceware.com> from "Mike Panetta" at Mar 08, 2001 04:41:12 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14bBCv-00046u-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am using VMware to test a linux install
> and since I have upgraded to 2.4.2-ac14
> the VM locks up right after:

Last time I looked at reports like this it seemed that vmware wasnt
good enough to emulate all the stuff the 2.4 kernel uses. You may find you
can get it to work with the nmi watchdog and apic disabled
