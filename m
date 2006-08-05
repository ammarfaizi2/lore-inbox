Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161222AbWHEKmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161222AbWHEKmE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 06:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWHEKmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 06:42:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:23767 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751452AbWHEKmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 06:42:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JQLdQ8WTviPK2+2JgGoos3ZnmLUoC8NPKtcJ7pfEdA7G02IgFwQAdq8xR2D1OVb/B9zofi60ywZsni9cyxbUanpb0UwFyW45J/cbFOAQ6mltnbLBmjiCSjui79XmFn+jf4XkhfVGlRrr12cs8CHCBb+JEOcLx0lTP9skOGpkMXM=
Message-ID: <44D47661.8080000@gmail.com>
Date: Sat, 05 Aug 2006 12:43:45 +0200
From: Alessandro Guido <alessandro.guido.box@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060729)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: Sony ACPI extras mainline inclusion
References: <44CB288A.1010702@gmail.com> <20060802100314.GF7601@ucw.cz>
In-Reply-To: <20060802100314.GF7601@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> I own a Sony VAIO laptop that uses ACPI for setting 
>> screen brightness
>> through the "2.6-sony_acpi4.patch" patch that has been 
>> living in -mm for a while.
>> I'd like this patch to be merged in mainline, so that I 
>> won't be forced anymore to patch
>> the kernel by hand or to use the -mm patchset.
>> Is there something that prevents this to happen?
> 
> Wrong interface?
> 
> Convert it to use /sys/class/backlight sysfs interface...
> 
> 						Pavel

Thank you for repling!

I found a patch that does it in the mailing list archives,
although I've not tested if it can be still applied correctly:

http://marc.theaimsgroup.com/?l=linux-acpi&m=113950408508944&w=2
