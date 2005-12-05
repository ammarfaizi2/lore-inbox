Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVLEKzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVLEKzu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 05:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVLEKzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 05:55:49 -0500
Received: from cantor2.suse.de ([195.135.220.15]:38321 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932366AbVLEKzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 05:55:49 -0500
From: Marcus Meissner <meissner@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
In-Reply-To: <1133714480.5188.62.camel@laptopd505.fenrus.org.suse.lists.linux.kernel>
X-Newsgroups: suse.lists.linux.kernel
User-Agent: tin/1.6.2-20030910 ("Pabbay") (UNIX) (Linux/2.6.13-15.7-ppc64 (ppc64))
Message-Id: <20051205105547.C8B397C95B@grape.suse.de>
Date: Mon,  5 Dec 2005 11:55:47 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1133714480.5188.62.camel@laptopd505.fenrus.org.suse.lists.linux.kernel> you wrote:
> On Sun, 2005-12-04 at 17:11 +0100, Matthias Andree wrote:
>> On Sun, 04 Dec 2005, Arjan van de Ven wrote:
>> 
>> > On Sun, 2005-12-04 at 15:57 +0100, M. wrote:
>> > 
>> > > 
>> > > if distros would align on those 6months versions those less
>> > > experienced users would get 5 years support on those kernels. 
>> > 
>> > no distro gives 5 years of support for a kernel done every 6 months;
>> > they start such projects more like every 18 to 24 months (SuSE used to
>> > do it a bit more frequently but it seems they also slowed this down).
>> 
>> SUSE end-user distros (SUSE LINUX <version>) are released every 6 months
>> or so, and are supported for 24 months. Their "enterprise server" is
>> supported for 60 months though, SLES 9 forked off 9.1.
> 
> sure.. but they don't add new hw support really, and I'd not be
> surprised if they rebase to a newer upstream kernel after a while. I
> know we did that for RHL, eg RHL 7.(Y-1) got the kernel of RHL7.Y after
> RHL7.Y was released, not only to keep the maintenance down, but more so
> to get all the bugfixes and hardware support out to customers. 

We tried rebasing the kernel from 2.4.19 to 2.4.21 in a SLES 8 service
pack. It was like doing a new product.

Currently for SLES our policy is to add new driver support at Service Pack
releases.... Currently this list includes major updates to e1000 and other
Gigabit network drivers for instance (and likely other things, I am not
really keeping track).

So:

- SUSE Linux distro every 6 months with then current mainline, 
  24 months lifetime, kernel gets only critical bugfixes and security fixes.


- SUSE Linux Enterprise Line (every 18 - 24 months) with then current mainline,
  kernel version stays stable.

  Non Service Pack kernel updates:
  	- security and critical bugfixes only.

  Service Packs kernel updates:
  	- new features (but only with backing business case/ partner request)
	- driver updates for enterprise critical hardware

Ciao, Marcus (only responsible for the security part luckily)
