Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261794AbTCGViG>; Fri, 7 Mar 2003 16:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261800AbTCGViF>; Fri, 7 Mar 2003 16:38:05 -0500
Received: from holomorphy.com ([66.224.33.161]:27563 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261794AbTCGVhk>;
	Fri, 7 Mar 2003 16:37:40 -0500
Date: Fri, 7 Mar 2003 13:47:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Dukes <pakrat@www.uk.linux.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: Make ipconfig.c work as a loadable module.
Message-ID: <20030307214749.GA20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Chris Dukes <pakrat@www.uk.linux.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>, Robin Holt <holt@sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netdev@oss.sgi.com
References: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com> <1046990052.18158.121.camel@irongate.swansea.linux.org.uk> <20030306221136.GB26732@gtf.org> <20030306222546.K838@flint.arm.linux.org.uk> <1046996037.18158.142.camel@irongate.swansea.linux.org.uk> <20030306231905.M838@flint.arm.linux.org.uk> <1046996987.17718.144.camel@irongate.swansea.linux.org.uk> <20030307000816.P838@flint.arm.linux.org.uk> <20030307012905.G20725@parcelfarce.linux.theplanet.co.uk> <20030307094235.A11807@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307094235.A11807@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 09:42:35AM +0000, Russell King wrote:
> That's getting on for 2MB vs:
>    2620    2012       0    4632    1218 fs/nfs/nfsroot.o
>    8016     380      80    8476    211c net/ipv4/ipconfig.o
> about 13K.

There's a cap on the maximum size of things various bootloaders can
load via tftp; 2MB is relatively certain to blow it. ISTR the limit
being something near 1MB for 2 of my boxen.


-- wli
