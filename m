Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbUDGWdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264194AbUDGWdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:33:10 -0400
Received: from ns.suse.de ([195.135.220.2]:63459 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261181AbUDGWdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:33:05 -0400
Date: Thu, 8 Apr 2004 00:33:00 +0200
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: akpm@osdl.org, colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
Message-Id: <20040408003300.7ada1861.ak@suse.de>
In-Reply-To: <6560000.1081377557@flay>
References: <1081373058.9061.16.camel@arrakis>
	<20040407145130.4b1bdf3e.akpm@osdl.org>
	<20040408001629.2ff39598.ak@suse.de>
	<6560000.1081377557@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Apr 2004 15:39:17 -0700
"Martin J. Bligh" <mbligh@aracnet.com> wrote:

> >> ppc64+CONFIG_NUMA compiles OK.
> > 
> > ppc64 doesn't have the system calls hooked up, but I'm not sure how useful
> > it would be for these boxes anyways (afaik they are pretty uniform) 
> 
> They actually are fairly keen on doing NUMA for HPC stuff - it makes
> a significant performance improvement ...

Ok. Should be straight forward to add system calls them if they're
interested. 

The hugetlbpages may need some work though, but that's non essential for 
the beginning.

The new calls are all emulation clean too, you can just hand them through.
[i didn't add that yet, but it would be pretty simple]

-Andi
