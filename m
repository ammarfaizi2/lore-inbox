Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267461AbUHZEdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267461AbUHZEdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 00:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267465AbUHZEdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 00:33:25 -0400
Received: from holomorphy.com ([207.189.100.168]:35730 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267461AbUHZEdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 00:33:24 -0400
Date: Wed, 25 Aug 2004 21:33:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: jmerkey@comcast.net
Cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Message-ID: <20040826043318.GO2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	jmerkey@comcast.net, linux-kernel@vger.kernel.org,
	jmerkey@drdos.com
References: <082620040421.9849.412D655C000690BA000026792200735446970A059D0A0306@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <082620040421.9849.412D655C000690BA000026792200735446970A059D0A0306@comcast.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 04:21:48AM +0000, jmerkey@comcast.net wrote:
> That incredibly useful patch for 2.4.X that Andrea wrote that splits
> the kernel user space into 1GB/2GB/3GB sections  I ported to 2.6.8.1
> and posted it to:
> ftp.kernel.org:/pub/linux/kernel/people/jmerkey/patches/linux-2.6.8.1-highmem-split-08-25-04.patch
> I was not able to located a 2.6.8 version of this patch so I ported
> one.  I apologize in advance if I replicated anyone elses work.
> Using HIGHMEM (aka.  the extended Linux TLB reloading hits/second
> test) is not optimal for embedded systems and appliance versions of
> Linux we use so this is submitted.  I'll maintain this patch (and
> keep it working) for folks who need it.
> Would be nice to have in the kernel for appliance Linux.
> ** I CERTIFY THAT THIS CODE DOES NOT CONTAIN ANY INTELECTUAL PROPERTY 
> OF ANYONE OTHER THAN THE ORIGINAL LINUX CONTRIBUTORS THE FILES
> WERE DERIVED FROM. ***

ELF ABI violation. "...the reserved area shall not consume more than
1GB of the address space."


-- wli
