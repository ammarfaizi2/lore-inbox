Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269003AbUIQXVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269003AbUIQXVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 19:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269018AbUIQXVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 19:21:06 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:6960 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269003AbUIQXVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 19:21:00 -0400
Message-ID: <470b6397040917162033bfa880@mail.gmail.com>
Date: Fri, 17 Sep 2004 16:20:53 -0700
From: Tony Lee <tony.p.lee@gmail.com>
Reply-To: Tony Lee <tony.p.lee@gmail.com>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: The ultimate TOE design
Cc: valdis.kletnieks@vt.edu, Eric Mudama <edmudama@gmail.com>,
       David Stevens <dlstevens@us.ibm.com>, Netdev <netdev@oss.sgi.com>,
       leonid.grossman@s2io.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60.0409171333510.24478@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4148991B.9050200@pobox.com>
	 <OF8783A4F6.D566336C-ON88256F10.006E51CE-88256F10.006EDA93@us.ibm.com>
	 <311601c90409162346184649eb@mail.gmail.com>
	 <200409172027.i8HKRVwY005444@turing-police.cc.vt.edu>
	 <Pine.LNX.4.60.0409171333510.24478@dlang.diginsite.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004 13:36:14 -0700 (PDT), David Lang
<david.lang@digitalinsight.com> wrote:
> actually the sector based access that is made to modern drives is a very
> primitive filesystem. if you go back to the days of the MFM and RLL drives
> you had the computer sending the raw bitstreams to the drives, but with
> SCSI and IDE this stopped and you instead a higher level logical block to
> the drive and it deals with the details of getting it to and from the
> platter.
> 
> David Lang
> 

Maybe next evolutionary step is to put VFS layer directory on top of
RDMA -> PCI
Express/Latest serial IO, etc.
Similar to access file thru NFS/SMB just on a faster standardize
(RDMA) transport.


On the networking front, instead of TOE, it should be services
offload, similar to
web load balancer.     Offload service base on src/dest addr port
proto (tcp/udp).
NSO (Network service offload.)    - kind of like Apache's reverse proxy 
with URL rewrite, but maybe for other applications. 



Question for Leonid of S2io.com:  Your company has an interesting card.
I think it must have some kind of embedded CPU.  Care to tell us what kind 
of CPU are they?


-- 
-Tony
Having a lot of fun with Xilinx Virtex Pro II reconfigurable HW + ppc + Linux
