Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261667AbSJCPXS>; Thu, 3 Oct 2002 11:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261672AbSJCPXS>; Thu, 3 Oct 2002 11:23:18 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:18155 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261667AbSJCPXP>; Thu, 3 Oct 2002 11:23:15 -0400
Message-ID: <3D9C62BE.2090408@snapgear.com>
Date: Fri, 04 Oct 2002 01:31:10 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.40-ac1
References: <20021003151707.A17513@infradead.org>	<200210031420.g93EK3L07983@devserv.devel.redhat.com> 	<20021003155122.A20437@infradead.org> <1033658738.28814.7.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Thu, 2002-10-03 at 15:51, Christoph Hellwig wrote:
> 
>>Did you actually take a look?  Many files are basically the same and other
>>are just totally stubbed out in nommu.
> 
> 
> Basically but never entirely - if you can see a way to clean that up
> nicely that Linus would accept other than mmnommu then thats even
> better. I couldnt see a way of getting enough ifdefs out of the tree

And this really is the problem. There is a lot of ifdefs, lots
of little differences. I am not sure how exactly we could
clean this up.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

