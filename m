Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbTFUOPz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 10:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTFUOPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 10:15:54 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59591
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264472AbTFUOPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 10:15:52 -0400
Subject: Re: 2.4.21 / IDE lost interrupt / ServerWorks problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: jfontain@free.fr, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <200306170839.43695.baldrick@wanadoo.fr>
References: <1055763075.3eedaa83b19c8@imp.free.fr>
	 <200306170839.43695.baldrick@wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056205656.25975.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jun 2003 15:27:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-06-17 at 07:39, Duncan Sands wrote:
> > I just upgraded from a 2.4.20 to 2.4.21 but had to revert due to the
> > following errors:
> >  hdd: dma_timer_expiry: dma status == 0x60
> >  hdd: timeout waiting for DMA
> >  hdd: lost interrupt
> 
> I've been seeing the same problem with 2.4.21.  I've attached my 2.4.21 log
> (with email + firewall reports removed).

If its uniprocessor disable APIC support or run -ac

