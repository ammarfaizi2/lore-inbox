Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267212AbTAAJUg>; Wed, 1 Jan 2003 04:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267213AbTAAJUg>; Wed, 1 Jan 2003 04:20:36 -0500
Received: from holomorphy.com ([66.224.33.161]:16576 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267212AbTAAJUf>;
	Wed, 1 Jan 2003 04:20:35 -0500
Date: Wed, 1 Jan 2003 01:28:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Greg KH <greg@kroah.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       hohnbaum@us.ibm.com, mochel@osdl.org
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <20030101092857.GO9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Greg KH <greg@kroah.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
	Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
	hohnbaum@us.ibm.com, mochel@osdl.org
References: <177250000.1037141189@flay> <20021112215305.GZ23425@holomorphy.com> <179150000.1037145229@flay> <20021112225937.GA23425@holomorphy.com> <20021112235824.GG22031@holomorphy.com> <20021113000435.GE32274@kroah.com> <20021113001246.GC23425@holomorphy.com> <20021113002032.GF32274@kroah.com> <20021113101005.GH23425@holomorphy.com> <20021113112028.GI23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021113112028.GI23425@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 04:20:32PM -0800, Greg KH wrote:
>>> Ok, then also please fix up drivers/pci/probe.c::pci_setup_device() to
>>> set a unique slot_name up for the pci_dev, if you have multiple
>>> domains/segments.

On Wed, Nov 13, 2002 at 02:10:05AM -0800, William Lee Irwin III wrote:
>> Reporting that stuff is trivial, but resolving the deep arch issues
>> with the remaining failures I'm getting (not directly bus-related,
>> actually I/O resource allocation going wrong) have me badly stumped.
>> Push back that ETA to weeks. I'll break off generically mergeable
>> bits and send them your way as I go though. The patch queue is
>> something like 20 long, but most of the content is "resolve one
>> problem after the other". Getting this into a state of "the system
>> works at every step of the way" is tricky, esp. since the end results
>> of today's excursion do not yet include a fully-working system.

On Wed, Nov 13, 2002 at 03:20:28AM -0800, William Lee Irwin III wrote:
> Actually benh has straightened me out on this count as of a few minutes
> ago. Something will probably show up here by Friday.

I've had a lot of trouble with this. Don't count on this anytime soon.

Bill
