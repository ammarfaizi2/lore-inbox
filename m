Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbSJUVjM>; Mon, 21 Oct 2002 17:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261663AbSJUVjM>; Mon, 21 Oct 2002 17:39:12 -0400
Received: from air-2.osdl.org ([65.172.181.6]:17280 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261413AbSJUVjE>;
	Mon, 21 Oct 2002 17:39:04 -0400
Date: Mon, 21 Oct 2002 14:48:17 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Matthew Dobson <colpatch@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
       Martin Bligh <mjbligh@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc][patch] DriverFS Topology + per-node (NUMA) meminfo
In-Reply-To: <3DB47396.4070505@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0210211447110.983-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey there. 

> 	Here's I've been sitting on a bit too long.  This patch adds Topology 
> information to driverfs, and adds a meminfo file to each node's 
> directory which contains: <drum roll> that nodes memory info!
> 	Pat, I got rid of the per-arch callbacks, since they weren't doing 
> anything even remotely useful yet, and they bloated the patch even 
> further.  I left in the arch_info pointers so we can put the arch 
> specific callbacks back in if anyone wants...  I've also rolled Martin's 
> /proc/meminfo.numa patch into this.
> 	BTW, I have a patch that will changes the usage of 'int numnodes' into 
> the more generic 'num_online_nodes()' and 'node_set_online()' calls. 
> I'll be sending that patch momentarily also.
> 	As always: comment, question, and flame away!


Do we get to see the patch, or was it typed in that pesky invisible font? 
;)

	-pat




