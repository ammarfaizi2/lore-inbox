Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVAKD0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVAKD0P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVAKDZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 22:25:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39808 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262412AbVAKDYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 22:24:40 -0500
Date: Mon, 10 Jan 2005 22:23:43 -0500
From: Dave Jones <davej@redhat.com>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.10] Updated pci.ids for new IBM bridge
Message-ID: <20050111032343.GM30515@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	James Cleverdon <jamesclv@us.ibm.com>, linux-kernel@vger.kernel.org
References: <200501101842.42267.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501101842.42267.jamesclv@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 06:42:42PM -0800, James Cleverdon wrote:
 > Update patch for a forthcoming bridge.
 > 
 > X-Signed-Off-By: James Cleverdon <jamesclv@us.ibm.com>
 > 
 > 
 > diff -pru 2.6.10/drivers/pci/pci.ids t10/drivers/pci/pci.ids
 > --- 2.6.10/drivers/pci/pci.ids	2004-12-24 13:34:57.000000000 -0800
 > +++ t10/drivers/pci/pci.ids	2005-01-04 16:36:28.284492825 -0800
 > @@ -998,6 +998,7 @@
 >  	0269  10/100/1000 Base-TX Ethernet Adapter (PCI-X)
 >  	028C  Citrine chipset SCSI controller
 >  		1014 02BE  Dual Channel PCI-X U320 DDR SCSI RAID Adapter (571B)
 > +	02a1  X-Architecture Bridge rev 3 [Summit2/EXA-32e]
 >  	0302  X-Architecture Bridge [Summit]
 >  	ffff  MPIC-2 interrupt controller
 >  1015  LSI Logic Corp of Canada

Please add this bit to  http://pciids.sf.net 
It'll then find its way into pciutils, and everything else that
uses pci.ids

		Dave

