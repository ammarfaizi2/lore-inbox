Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264846AbTIDKfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 06:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264899AbTIDKfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 06:35:46 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:15570 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264846AbTIDKfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 06:35:45 -0400
Subject: Re: [PATCH] fix ppc ioremap prototype
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>, rmk@arm.linux.org.uk, hch@lst.de,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030904023624.592f1601.davem@redhat.com>
References: <20030903203231.GA8772@lst.de>
	 <16214.34933.827653.37614@nanango.paulus.ozlabs.org>
	 <20030904071334.GA14426@lst.de>
	 <20030904083007.B2473@flint.arm.linux.org.uk>
	 <16215.1054.262782.866063@nanango.paulus.ozlabs.org>
	 <20030904023624.592f1601.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062671669.21777.9.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Thu, 04 Sep 2003 11:34:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-04 at 10:36, David S. Miller wrote:
> You only need a resource in order to do this.  Then you can
> stick the upper bits, controller number, whatever in the unused
> resource flag bits.

If it becomes the default approach over time then we also need a 
version that allows offset/len to be included for mapping parts
of very large objects (like 256Mb frame buffers)

