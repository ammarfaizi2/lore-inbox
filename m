Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUBGHbh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 02:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUBGHbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 02:31:37 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:36305 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S266498AbUBGHbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 02:31:32 -0500
Date: Fri, 06 Feb 2004 23:31:22 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving X  (fwd)
Message-ID: <33170000.1076139081@[10.10.2.4]>
In-Reply-To: <402487A5.4030806@cyberone.com.au>
References: <51080000.1075936626@flay.suse.lists.linux.kernel><64260000.1075941399@flay.suse.lists.linux.kernel><Pine.LNX.4.58.0402041639420.2086@home.osdl.org.suse.lists.linux.kernel><20040204165620.3d608798.akpm@osdl.org.suse.lists.linux.kernel><Pine.LNX.4.58.0402041719300.2086@home.osdl.org.suse.lists.linux.kernel><1075946211.13163.18962.camel@dyn318004bld.beaverton.ibm.com.suse.lists.linux.kernel><Pine.LNX.4.58.0402041800320.2086@home.osdl.org.suse.lists.linux.kernel><98220000.1076051821@[10.10.2.4].suse.lists.linux.kernel><1076061476.27855.1144.camel@nighthawk.suse.lists.linux.kernel>
 <5450000.1076082574@[10.10.2.4].suse.lists.linux.kernel><1076088169.29478.2928.camel@nighthawk.suse.lists.linux.kernel><218650000.1076097590@flay.suse.lists.linux.kernel><Pine.LNX.4.58.0402061215030.30672@home.osdl.org.suse.lists.linux.kernel><220850000.1076102320@flay.suse.lists.linux.kernel> <p738yjflf38.fsf@verdi.suse.de> <14230000.1076129379@[10.10.2.4]> <402487A5.4030806@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 1 --- 2
>>|     | 
>>|     | 
>>|     | 
>> 3 --- 4
>> 
>> then domains of (1,2,3) (2,3,4) (1,3,4) (1 2 4), with a view to restricting
>> the "double hop" traffic as much as possible. But I'm not sure the domains
>> code copes with multiple overlapping domains - Nick?
>> 
>> 
> 
> Yes it can do ring topologies like this. I'm pretty sure it can do
> just about any sort of topology although this is one that I sat
> down and drew when designing it.
> 
> You can technically restrict a double hop, but after you move, say,
> clockwise once, you might just as easily be moved clockwise again.
> The only way to restrict this is with some kind of home domain thing.

Well, this doesn't ban it, but requiring the double migrate will curtail
it somewhat, which is better than nothing.

M.

