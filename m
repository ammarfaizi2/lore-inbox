Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbVKCRHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbVKCRHn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 12:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbVKCRHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 12:07:43 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:53764 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1030390AbVKCRHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 12:07:42 -0500
Message-ID: <436A4394.5080608@shadowen.org>
Date: Thu, 03 Nov 2005 17:06:28 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob Picco <bob.picco@hp.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       Dave Hansen <haveblue@us.ibm.com>,
       Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>,
       matthew.e.tolentino@intel.com, discuss@x86-64.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi> <1130607017.12551.5.camel@localhost> <20051031001727.GC6019@localhost.localdomain> <200510310312.18395.ak@suse.de> <222900000.1130908059@[10.10.2.4]> <43690083.5020605@shadowen.org> <20051103144305.GA22938@localhost.localdomain>
In-Reply-To: <20051103144305.GA22938@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Picco wrote:

> Matt responded to a private that I posted to Dave and Matt. Matt is
> traveling and told me to go ahead and post a fix.
> 
> I removed memory_present called from the FLATMEM routine contig_initmem_init.
> Otherwise my original quick patch used for testing SPARSEMEM EXTREME
> was nearly complete.
> 
> I've boot tested all three configurations (SPARSEMEM, DISCONTIGMEM and CONTIG)
> on my DL585 (4 node machine).

I'll test on it and let you know if it works for me too.

Thanks.

-apw
