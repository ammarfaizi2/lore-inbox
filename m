Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbVCDXn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbVCDXn2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263230AbVCDXiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:38:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52931 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S263264AbVCDVeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:34:16 -0500
Message-ID: <4228D43E.1040903@pobox.com>
Date: Fri, 04 Mar 2005 16:33:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       torvalds@osdl.org
Subject: Re: Linux 2.6.11.1
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org>
In-Reply-To: <20050304124431.676fd7cf.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> 
>>A few of us $suckers will be trying to maintain a 2.6.x.y set of
>> 	releases that happen after 2.6.x is released.
> 
> 
> Just to test things out a bit...
> 
> Here's the list of things which we might choose to put into 2.6.11.2.  I was
> planning on sending them in for 2.6.12 when that was going to be
> errata-only.
> 
> 
>>From 2.6.11-mm1:
> 
> cramfs-small-stat2-fix.patch
> setup_per_zone_lowmem_reserve-oops-fix.patch
> dv1394-ioctl-retval-fix.patch
> ppc32-compilation-fixes-for-ebony-luan-and-ocotea.patch
> nfsd--sgi-921857-find-broken-with-nohide-on-nfsv3.patch
> nfsd--exportfs-reduce-stack-usage.patch

Unless it's crashing for people, stack usage is IMO a wanted-fix not 
needed-fix.


> nfsd--svcrpc-add-a-per-flavor-set_client-method.patch

is this critical?

	Jeff


