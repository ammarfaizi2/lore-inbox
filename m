Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbTDXToa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 15:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263754AbTDXToa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 15:44:30 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11652
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263824AbTDXTo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 15:44:28 -0400
Subject: Re: [Motion] Re: IDE corruption during heavy bt878-induced interr
	upt load [LKM]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: joe briggs <jbriggs@briggsmedia.com>
Cc: David Brodbeck <DavidB@mail.interclean.com>,
       "'motion@lists.frogtown.com'" <motion@pdx.frogtown.com>,
       andras@t-online.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       motion@frogtown.com
In-Reply-To: <200304240631.49222.jbriggs@briggsmedia.com>
References: <C823AC1DB499D511BB7C00B0D0F0574C583D23@serverdell2200.interclean.com>
	 <200304231813.46892.jbriggs@briggsmedia.com>
	 <1051135875.2062.101.camel@dhcp22.swansea.linux.org.uk>
	 <200304240631.49222.jbriggs@briggsmedia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051210647.4017.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Apr 2003 19:57:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-24 at 11:31, joe briggs wrote:
> Specifically, if a PCI board is DMA'ing a block of data to main memory, how 
> is the operation of the direct-connect IDE device impacted?  When most PCI 
> devices transfer data to main memory, don't they arbitrate the bus, become 
> master, and blast it accross in chunks?  Doesn't onboard IDE (legacy?) use 
> the DMA controller (8237 derivate I gues) to transfer?

Onboard legacy mode IDE doing PCI DMA is doing it directly. How onboard
and southbridge IDE interact is a complicated field and chipset
dependant.


