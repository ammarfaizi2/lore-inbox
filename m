Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUIOAYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUIOAYH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 20:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUIOAXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 20:23:00 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:20390 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S264954AbUIOAVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 20:21:19 -0400
Message-ID: <41478AFD.2080700@candelatech.com>
Date: Tue, 14 Sep 2004 17:21:17 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lawrence Wong <lawrencewong72@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.8.6.1 & VLAN & E100
References: <20040914143339.30588.qmail@web53501.mail.yahoo.com>
In-Reply-To: <20040914143339.30588.qmail@web53501.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lawrence Wong wrote:
> Hi everyone,
> 
> I am currently using Fedora Core 2 on a P3 w/512MB
> RAM, 2 x 18.2GB SCSI in RAID1 via an IBM ServeRAID-4M.
> Network card is an Intel 100 S controller.
> 
> All except the kernel is stock FC2. The kernel is
> 2.6.8.1 and compiled from the tarball found on
> ftp.kernel.org .
> 
> Everything works fine until I tried to enable VLAN and
> use VLAN subinterfaces. The VLAN subinterface comes up
> fine but the moment I send traffic in/out of the
> interface (i.e. ping), a huge and neverending chunk of
> "bad scheduling while atomic" errors pop up
> immediately and does not go away until I press
> CTRL+ALT+DEL.
> 
> An extract of the error can be found below. But when I
> run the system in normal non-VLAN mode, the problem
> does not occur. So I am inclined to believe it either
> has something to do with the VLAN driver or VLAN
> driver + INTEL 10/100 driver.
> 
> Has anyone encountered before or know of any
> solutions?

A patch is in the latest bk tree, at least.

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

