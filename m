Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266677AbUBGHf6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 02:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266681AbUBGHf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 02:35:58 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:35043 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S266677AbUBGHf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 02:35:57 -0500
Date: Fri, 06 Feb 2004 23:35:49 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, anton@samba.org
Subject: Re: Manfreds patch to distribute boot allocations across nodes
Message-ID: <34340000.1076139348@[10.10.2.4]>
In-Reply-To: <p734qu3lahj.fsf@verdi.suse.de>
References: <20040207042559.GP19011@krispykreme.suse.lists.linux.kernel><20040206210428.17ee63db.akpm@osdl.org.suse.lists.linux.kernel> <p734qu3lahj.fsf@verdi.suse.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > +#ifdef CONFIG_NUMA
>> 
>> Is this a thing which all NUMA machines want to be doing?
> 
> Should be ok yes. The free_pages in zone check should catch the 
> 32bit NUMAs which only have lowmem in node 0.

Doesn't matter much either way - alloc_pages_node for anything should
point us to node 0.

M.

