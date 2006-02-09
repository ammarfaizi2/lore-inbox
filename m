Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWBIVjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWBIVjf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 16:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWBIVje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 16:39:34 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:62857 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750803AbWBIVjd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 16:39:33 -0500
Message-ID: <43EBB68A.3040105@austin.ibm.com>
Date: Thu, 09 Feb 2006 15:39:22 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: Yasunori Goto <y-goto@jp.fujitsu.com>, Andi Kleen <ak@suse.de>,
       "Brown, Len" <len.brown@intel.com>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       "S, Naveen B" <naveen.b.s@intel.com>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, x86-64 Discuss <discuss@x86-64.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [RFC:PATCH(000/003)] Memory add to onlined node.
 (ver. 2)
References: <B8E391BBE9FE384DAA4C5C003888BE6F05AA16C3@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F05AA16C3@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> - if the node is already online.-  If the node is offline, 
>> (It means new node is comming!)  then the memory will belongs
>> to node 0 yet.
> 
> What is the long term plan to address this?  Can you make sure
> that the new node is always brought online before you get to
> this code?  Or will you have to bring the node online in the
> middle of the memory hot-add code?
> 
> Presumably there is a similar issue with hot add cpu.
> 

Yes, cpu hot add has the same issue.  It's really a performance issue, 
not a functional one so you haven't seen people beating down the doors 
to fix it.

Technically there isn't anything but manpower standing in the way of 
doing it.  But it is a good amount of work for the little it gains.

-Joel
