Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSG1J7T>; Sun, 28 Jul 2002 05:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSG1J7T>; Sun, 28 Jul 2002 05:59:19 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:917 "EHLO
	gusi.leathercollection.ph") by vger.kernel.org with ESMTP
	id <S315720AbSG1J7S>; Sun, 28 Jul 2002 05:59:18 -0400
Date: Sun, 28 Jul 2002 18:02:22 +0800
From: Federico Sevilla III <jijo@free.net.ph>
To: Linux-XFS Mailing List <linux-xfs@oss.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel BUG at page_alloc.c:91 (2.4.19-rc2-xfs)
Message-ID: <20020728100222.GF1265@leathercollection.ph>
Mail-Followup-To: Linux-XFS Mailing List <linux-xfs@oss.sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020728082542.GC1265@leathercollection.ph> <20020728084718.GW1548@niksula.cs.hut.fi> <20020728090336.GD1265@leathercollection.ph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020728090336.GD1265@leathercollection.ph>
User-Agent: Mutt/1.4i
X-Organization: The Leather Collection, Inc.
X-Organization-URL: http://www.leathercollection.ph
X-Personal-URL: http://jijo.free.net.ph
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 05:03:36PM +0800, Federico Sevilla III wrote:
> Ah, yes, I had forgotten to do that. I hadn't realized that the same
> requirement for reporting oopses held for reporting kernel BUGs.

I had further forgotten to mention that I have the NVidia 2960 binary
module loaded, and that D. Stimits just posted a message on the
Linux-XFS mailing list about a kernel BUG report also on page_alloc.c:91
on a similar 2.4.19-rc2-xfs CVS snapshot, also with the NVdriver module
loaded.

Kjell Randa noted that an upgrade to version 2960 fixed things for him,
and Kjell Randa added that removing "agpgart" support fixes things. I
have agpgart support for my VIA chipset, and it's possible that this is
clashing with the NVdriver.

I realize that I may have wasted people's time, since the NVidia driver
is closed-source binary-only, and my system is tainted. I apologize for
this but hope that my messages will at least help some other people who
may run into this problem and will search the archives.

I am upgrading to 2.4.19-rc3-xfs now, and will remove agpgart support
from the kernel. I am keeping my fingers crossed.

 --> Jijo


-- 
Federico Sevilla III   :  <http://jijo.free.net.ph/>
Network Administrator  :  The Leather Collection, Inc.
GnuPG Key ID           :  0x93B746BE
