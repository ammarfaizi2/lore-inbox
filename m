Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261211AbTCFXOG>; Thu, 6 Mar 2003 18:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261271AbTCFXOG>; Thu, 6 Mar 2003 18:14:06 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49064
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261211AbTCFXOE>; Thu, 6 Mar 2003 18:14:04 -0500
Subject: Re: Make ipconfig.c work as a loadable module.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <20030306231905.M838@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com>
	 <1046990052.18158.121.camel@irongate.swansea.linux.org.uk>
	 <20030306221136.GB26732@gtf.org>
	 <20030306222546.K838@flint.arm.linux.org.uk>
	 <1046996037.18158.142.camel@irongate.swansea.linux.org.uk>
	 <20030306231905.M838@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046996987.17718.144.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 07 Mar 2003 00:29:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 23:19, Russell King wrote:
> "klibc doesnt really matter"
> 
> I'd prefer not to have to have thousands of special programs around
> just to be able to boot my machines, especially when it was all in-
> kernel up until this point.
> 
> klibc yes, dietlibc with random other garbage in some random filesystem
> which'd need maintaining - no thanks.

You can build the dhcp client with glibc static into your initrd. Its hardly
magic or special programs or random garbage, and last time I counted it came
to one program. Dunno what the other 999 utilities your dhcp needs are ?

