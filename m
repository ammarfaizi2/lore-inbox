Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWBWOkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWBWOkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 09:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWBWOkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 09:40:41 -0500
Received: from fmr19.intel.com ([134.134.136.18]:22416 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751170AbWBWOkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 09:40:41 -0500
Message-ID: <43FDC958.7080803@linux.intel.com>
Date: Thu, 23 Feb 2006 15:40:24 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Patch to make the head.S-must-be-first-in-vmlinux order explicit
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <200602231442.19903.ak@suse.de> <43FDBF55.3060502@linux.intel.com> <200602231514.03001.ak@suse.de>
In-Reply-To: <200602231514.03001.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thursday 23 February 2006 14:57, Arjan van de Ven wrote:
> 
>>> (or at least
>>> it shouldn't), but arch/x86_64/boot/compressed/head.S
>>> seems to have the entry address hardcoded. Perhaps you can just change this
>>> to pass in the right address?
>> the issue is that the address will be a link time thing, which means 
>> lots of complexity.
> 
> bzImage image should be only generated after vmlinux is done 
> and then the address should be available with a simple grep in System.map
>

ok I'll look into this and see if the result is reasonable

