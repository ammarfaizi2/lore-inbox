Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTCDVy3>; Tue, 4 Mar 2003 16:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbTCDVy3>; Tue, 4 Mar 2003 16:54:29 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33697
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261463AbTCDVy3>; Tue, 4 Mar 2003 16:54:29 -0500
Subject: Re: Proposal: Eliminate GFP_DMA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Matthew Wilcox <willy@debian.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030304185616.A9527@bitwizard.nl>
References: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
	 <p73heao7ph2.fsf@amdsimf.suse.de>
	 <20030228141234.H23865@parcelfarce.linux.theplanet.co.uk>
	 <1046445897.16599.60.camel@irongate.swansea.linux.org.uk>
	 <20030228143405.I23865@parcelfarce.linux.theplanet.co.uk>
	 <1046447737.16599.83.camel@irongate.swansea.linux.org.uk>
	 <20030304185616.A9527@bitwizard.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046819369.12226.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 04 Mar 2003 23:09:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-04 at 17:56, Rogier Wolff wrote:
> All the modifier flags on kmalloc and GFP should be "memory allocation
> descriptors".
> A DMA pool descriptor will only point to pools that have that
> capability.

Much much too simple. DMA to what from where for example ? Post 2.6 its
IMHO a case of making the equivalent of pci_alloc_* pci_map_* work with
generic device objects now we have them.

