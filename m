Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbWHIGvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWHIGvn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 02:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbWHIGvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 02:51:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:18255 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965083AbWHIGvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 02:51:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R3HEQxyGnhZhhr/XrzsH3o9xyP9dKKbBPM4h4+RZiJC5V2S2CDy1H6prVL6SY2rC0KNTafZjlWrIiHGT1Rd66CF/As78KvB1T9EfYr6fs4P4WGVU42pyWM8v69GGsZ0MZoHfaGtMiga5R058vn94Hmy08jKA3NYRpbpffFUuUN8=
Message-ID: <f96157c40608082351j301efa57n412284f8d28124ef@mail.gmail.com>
Date: Wed, 9 Aug 2006 08:51:41 +0200
From: "gmu 2k6" <gmu2006@gmail.com>
To: davids@webmaster.com
Subject: Re: Only 3.2G ram out of 4G seen in an i386 box
Cc: "Thomas Stewart" <thomas@stewarts.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKKEDCNKAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060808101504.GJ2152@stingr.net>
	 <MDEHLPKNGKAHNMBLJOLKKEDCNKAB.davids@webmaster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, David Schwartz <davids@webmaster.com> wrote:
>
> > Replying to Thomas Stewart:
>
> > > Hi,
> > > I have a Dell Optiplex GX280, a Pentium 4 with an Intel chipset. It has
> > > 4G of ram. The problem is I can only see 3.2G, even tho the bios reports
> > > 4G.
>
> > Chipset issue. Some Intel chipsets are doing strange things with memory
> > map. They call this "design flaw" but not offered free replacements
> > yet, so, for example, on SE7221BK1E you can't use more than 3 gigs.
>
>        It is quite funny to read Intel's technical note on this, as they try to
> make it seem like they're blaming the operating system. For example:
>
> When the Intel E7221 chipset is populated to its maximum memory capacity of
> 4 GB (Giga Bytes), the Operating System (OS) may report a significantly
> lower amount of available memory.
>
>        Yeah, that stupid operating system.
>
> These requirements may reduce the addressable memory space available to and
> reported by the Operating System. These memory ranges, while unavailable to
> the OS, are still being utilized by subsystems such as I/O, PCI Express and
> Integrated Graphics and are critical to the proper functioning of the
> server.
>
> Use of Available memory below 4 GB by system resources is not specific to
> Intel chipsets, but rather a limitation of existing PC architectures and
> current limitations of some 32-bit operating systems. Some 32-bit operating
> systems may not be capable of recognizing greater than 2 GB of memory. This
> issue potentially impacts any chipset with 4GB maximum memory configuration.
>
> Intel has addressed this from a hardware perspective in future platforms,
> anticipating that future Operating Systems will provide greater than 4 GB of
> memory support.
>
>        Last but not least, their solution.
>
> Corrective Action / Resolution
> Intel Server Board SE7221BK1-E system BIOS will be updated to properly
> indicate the following information screens augment memory configuration
> characteristics for the Intel Server Board SE7221BK1-E and Intel Server
> Platform SR1425BK1-E customers.
>  Total physical memory populated in the system
>  Total memory dedicated to motherboard resources
>  Total memory reported as available to the operating system
> This information will align to the INT15h E820h standard that BIOS uses to
> communicate memory usage to the operating system. This BIOS feature will
> clarify the memory subsystem support and usage for the end user.
>
>        Are these technical notes supposed to be so funny?
>
>        DS

I guess this is all related to older Intel chipsets, right? I mean the
chipset *75X something I'm going to have in the new box I will get
soonish will support up to 8 GiB. I hope it does not mean that it will
be capped at 7.4GiB although I will only have 4GiB installed for now.
