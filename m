Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267089AbTB1Omc>; Fri, 28 Feb 2003 09:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267919AbTB1Omc>; Fri, 28 Feb 2003 09:42:32 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54929
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267089AbTB1Omc>; Fri, 28 Feb 2003 09:42:32 -0500
Subject: Re: Proposal: Eliminate GFP_DMA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030228143405.I23865@parcelfarce.linux.theplanet.co.uk>
References: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
	 <p73heao7ph2.fsf@amdsimf.suse.de>
	 <20030228141234.H23865@parcelfarce.linux.theplanet.co.uk>
	 <1046445897.16599.60.camel@irongate.swansea.linux.org.uk>
	 <20030228143405.I23865@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046447737.16599.83.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Feb 2003 15:55:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 14:34, Matthew Wilcox wrote:
> umm.  are you volunteering to convert drivers/net/macmace.c to the pci_*
> API then?  also, GFP_DMA is used on, eg, s390 to get memory below 2GB and
> on ia64 to get memory below 4GB.

The ia64 is a fine example of how broken it is. People have to hack around 
with GFP_DMA meaning different things on ia64 to everything else. It needs
to die. 

Alan

