Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBNMj3>; Wed, 14 Feb 2001 07:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbRBNMjT>; Wed, 14 Feb 2001 07:39:19 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:8889 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129055AbRBNMjN>; Wed, 14 Feb 2001 07:39:13 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200102141237.f1ECbPh15777@devserv.devel.redhat.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
To: becker@scyld.com (Donald Becker)
Date: Wed, 14 Feb 2001 07:37:25 -0500 (EST)
Cc: jes@linuxcare.com (Jes Sorensen), jgarzik@mandrakesoft.com (Jeff Garzik),
        ionut@moisil.cs.columbia.edu (Ion Badulescu),
        alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10102131627180.7141-100000@vaio.greennet> from "Donald Becker" at Feb 13, 2001 08:20:35 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There was not a bug in the driver.  The bug was/is in the protocol handling
> code.  The protocol handling code *must* be able to handle unaligned IP
> headers.

It does. It does so on IA64 now as well. The only architecture which has troubles
with alignment on IP frames now is ARM2

