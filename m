Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310374AbSCBNN1>; Sat, 2 Mar 2002 08:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310375AbSCBNNS>; Sat, 2 Mar 2002 08:13:18 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:53934 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S310374AbSCBNM7>;
	Sat, 2 Mar 2002 08:12:59 -0500
Date: Sat, 2 Mar 2002 14:12:54 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203021312.OAA23759@harpo.it.uu.se>
To: Martin.Bligh@us.ibm.com
Subject: Re: early ioremap not working with 2.4.19-pre1-aa1 ?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Mar 2002 15:46:14 -0800, Martin J. Bligh wrote:
>I have code for the NUMA-Q systems that does an ioremap
>as the first thing in smp_boot_cpus (ia32 tree). This seems to 
>work fine until I install the aa patches ... then it hangs in the 
>ioremap.

You may want to use the new boot-time ioremap, which is based
on the fixmap mechanism. It's included in 2.5.6-pre1; a separate
patch for 2.4.18 is available at
<http://www.csd.uu.se/~mikpe/linux/patches/2.4/>.

/Mikael
