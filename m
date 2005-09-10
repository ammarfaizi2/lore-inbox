Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVIJIjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVIJIjL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 04:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbVIJIjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 04:39:11 -0400
Received: from mail.dvmed.net ([216.237.124.58]:50578 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750702AbVIJIjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 04:39:10 -0400
Message-ID: <43229BA4.4010306@pobox.com>
Date: Sat, 10 Sep 2005 04:39:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jim Gifford <maillist@jg555.com>, linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
References: <43228E4E.4050103@jg555.com> <p73k6hp2up7.fsf@verdi.suse.de>
In-Reply-To: <p73k6hp2up7.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Jim Gifford <maillist@jg555.com> writes:
> 
> 
>>I have been working on a project to create a Pure 64 bit distro of
>>linux, nothing 32 bit in the system. I can accomplish that with no
> 
> 
> Hopefully you're using /lib64 for that, otherwise your
> packages will be incompatible to everybody else and not 
> FHS compliant. If you don't please don't submit any 
> patches to hardcode this to upstream packages.

/lib64 is an awful scheme.  I'd avoid it.

Consider what happens in the existing scenario where you have capability 
to run both IA64 and x86-64 binaries on the same system.


> The problem is that there is currently no defined protocol
> for passing data to the 64bit part of the kernel, so while
> it would be possible to write a boot loader that starts
> a 64bit kernel it would be very kernel version dependent.

Good point.

	Jeff


