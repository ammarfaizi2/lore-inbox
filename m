Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312511AbSDXStb>; Wed, 24 Apr 2002 14:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312524AbSDXSta>; Wed, 24 Apr 2002 14:49:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:39830 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S312511AbSDXSt3>;
	Wed, 24 Apr 2002 14:49:29 -0400
Date: Wed, 24 Apr 2002 12:47:05 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] patch to /proc/meminfo to display NUMA stats
Message-ID: <76000000.1019677625@flay>
In-Reply-To: <73870000.1019677180@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I also shifted the si_meminfo_node into mm/numa.c to make it generic for
> all machines, and made it loop through the node_next loop of pgdats to
> make it work on machines that have discontig within a node.

Sigh ... of course si_meminfo_node should have done += to the elements
within the loop, not =. Sorry,

M.

