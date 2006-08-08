Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWHHCPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWHHCPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 22:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWHHCPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 22:15:18 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:27806 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751173AbWHHCPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 22:15:16 -0400
Subject: Re: [Lhms-devel] [PATCH 1/10] hot-add-mem x86_64: acpi motherboard
	fix
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: andrew <akpm@osdl.org>, discuss <discuss@x86-64.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060808110855.b3a004a5.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
	 <20060805145137.aad34b44.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154975968.5790.16.camel@keithlap>
	 <20060808093110.f7b2ae04.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154998617.5790.31.camel@keithlap>
	 <20060808110855.b3a004a5.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Mon, 07 Aug 2006 19:15:07 -0700
Message-Id: <1155003308.5790.44.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 11:08 +0900, KAMEZAWA Hiroyuki wrote:
> On Mon, 07 Aug 2006 17:56:56 -0700
> keith mannthey <kmannth@us.ibm.com> wrote:
> 
> > I know of no x86_64 hardware the supports empty node hot-add memory.  If
> > it exists I would recommend using SPARSEMEM based hot-add.  On HW I am
> > aware of there is always some memory present in a node at boot.   
> >  
> > 
> O.K one more.
> 
> I know x86_64 has ZONE_DMA32. A system boot with only memory below 4G 
> has no avilable memory in ZONE_NORMAL. If a new memory above 4G is added,
> ZONE_NORMAL comes as *new* zone.
> ZONE_NORMAL is empty at boot, so it's not in zonelist at boot.
> 
> is this not problem ?

Perhaps in this situation you could run into trouble.  I am not sure if
I can put my hardware into this config but I will try.  

Thanks for taking a look at these patches and the reserve path. 

Thanks,
  Keith 

