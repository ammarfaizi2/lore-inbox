Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSKMUzI>; Wed, 13 Nov 2002 15:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbSKMUzI>; Wed, 13 Nov 2002 15:55:08 -0500
Received: from holomorphy.com ([66.224.33.161]:22467 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263039AbSKMUzF>;
	Wed, 13 Nov 2002 15:55:05 -0500
Date: Wed, 13 Nov 2002 12:59:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Greg KH <greg@kroah.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       hohnbaum@us.ibm.com, mochel@osdl.org
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <20021113205910.GJ23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Greg KH <greg@kroah.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
	Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
	hohnbaum@us.ibm.com, mochel@osdl.org
References: <177250000.1037141189@flay> <20021112215305.GZ23425@holomorphy.com> <179150000.1037145229@flay> <20021112225937.GA23425@holomorphy.com> <20021112235824.GG22031@holomorphy.com> <20021113000435.GE32274@kroah.com> <20021113001246.GC23425@holomorphy.com> <20021113002032.GF32274@kroah.com> <20021113002855.GD23425@holomorphy.com> <20021113150716.B1245@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021113150716.B1245@jurassic.park.msu.ru>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 03:07:16PM +0300, Ivan Kokshaysky wrote:
> Please use existing pci_controller_num(struct pci_dev *pdev).
> It does exactly that you want.

There are some other issues blocking a working implementation but
using that instead of a new function will be trivial.


Bill
