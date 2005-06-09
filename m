Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVFIXON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVFIXON (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 19:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVFIXON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 19:14:13 -0400
Received: from mail.dvmed.net ([216.237.124.58]:23256 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262273AbVFIXOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 19:14:07 -0400
Message-ID: <42A8CD2E.7020504@pobox.com>
Date: Thu, 09 Jun 2005 19:13:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>
CC: Andi Kleen <ak@muc.de>, James Ketrenos <jketreno@linux.intel.com>,
       Netdev list <netdev@oss.sgi.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
Subject: Re: ipw2100: firmware problem
References: <20050608142310.GA2339@elf.ucw.cz> <42A723D3.3060001@linux.intel.com> <m1is0nvdkw.fsf@muc.de> <20050609211242.GA30319@dspnet.fr.eu.org>
In-Reply-To: <20050609211242.GA30319@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> On Thu, Jun 09, 2005 at 03:56:15PM +0200, Andi Kleen wrote:
> 
>>I guess at some point we will need a file system in there, but - oops -
>>we already have one, dont we? :)
> 
> 
> Well, you could put .config in it too.
> 
> Frankly, a filesystem that:
> - can be somehow linked with vmlinux and not separate like an initrd
> 
> - editable post vmlinux-linking
> 
> - gives files that can be accessed from request_firmware, acpi and
>   friends even rather early in the boot process (i.e. well before any
>   userland is allowed to exist)
> 
> - accessible post-boot through mounting of a special fs and/or /proc or something
> 
> would be quite useful.

This exists.  It's called initramfs.  Read the kernel code :)

	Jeff



