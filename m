Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbUDHUWK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUDHUVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 16:21:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24480 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262788AbUDHUUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 16:20:47 -0400
Date: Thu, 8 Apr 2004 22:12:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: NUMA API for Linux
Message-ID: <20040408201226.GB468@openzaurus.ucw.cz>
References: <20040406153322.5d6e986e.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406153322.5d6e986e.ak@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This NUMA API doesn't not attempt to implement page migration or anything
> else complicated: all it does is to police the allocation when a page 
> is first allocation or when a page is reallocated after swapping. Currently
> only support for shared memory and anonymous memory is there; policy for 
> file based mappings is not implemented yet (although they get implicitely
> policied by the default process policy)
> 
> It adds three new system calls: mbind to change the policy of a VMA,
> set_mempolicy to change the policy of a process, get_mempolicy to retrieve
> memory policy. User tools (numactl, libnuma, test programs, manpages) can be 

set_mempolicy is pretty ugly name. Why is prctl inadequate?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

