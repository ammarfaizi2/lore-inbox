Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTFDF7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 01:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTFDF7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 01:59:22 -0400
Received: from franka.aracnet.com ([216.99.193.44]:63414 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262931AbTFDF7U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 01:59:20 -0400
Date: Tue, 03 Jun 2003 23:11:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Voorsluys <william@icmc.usp.br>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NPTL/SMP/NUMA
Message-ID: <227280000.1054707103@[10.10.2.4]>
In-Reply-To: <1054679535.9233.87.camel@dhcp22.swansea.linux.org.uk>
References: <Pine.GSO.4.05.10306031914120.1819-100000@ceci> <1054679535.9233.87.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> thinking on SMP machines, and which have been made to other purposes?
>> Is there any feature on the library/kernel that make it possible to
>> exploit the benefits of NUMA systems?
> 
> NUMA systems don't have any benefits (well other than engineering 
> considerations like practicality of construction). 

Personally, I'd say that's pretty important ;-) But I get your point ...

On the other hand, you could look at it as "better local latency" rather
than "worse remote latency". Particularly if you stand on a big Sun
server when you look, where everything sucks equally for memory access 
latencies ;-)

> From a software perspective NUMA is simply a question of making the 
> loss as little as possible.

 
> There are patches to do more NUMA aware scheduling which help a bit
> as well as to do things like replicate the kernel code to each node.

The NUMA scheduling code isn't very bright about threads right now,
but we will fix that soon enough ;-)

M.

