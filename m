Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267311AbTABXgq>; Thu, 2 Jan 2003 18:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267312AbTABXgq>; Thu, 2 Jan 2003 18:36:46 -0500
Received: from vger.timpanogas.org ([216.250.140.154]:42466 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S267311AbTABXgp>; Thu, 2 Jan 2003 18:36:45 -0500
Date: Thu, 2 Jan 2003 17:55:17 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: Questton about Zone Allocation 2.4.X
Message-ID: <20030102175517.A21471@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



LKML,

I have a system in the lab with 4GB of physical and the system can see all 
the memory, however, calls to get_free_pages() will only allocate up to 1GB
of this memory before returning an out of memory condition.  I have reviewed
Ingo's changes and enhancements with the zone allocator and it certainly 
looks like this code has the smarts to balance the contiguous free pages
on the zone allocation lists.  I need to be able to get more than 1GB to 
pin for a particular application.  Where do I need to adjust the tuning
to allow 2.4.X kernels to allocate mote than 1GB from the physical pages
list?

Any help would be appreciated.

Thanks

Jeff Merkey
Network Associates


