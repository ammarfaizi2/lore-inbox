Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWCQQxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWCQQxR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWCQQxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:53:17 -0500
Received: from fmr19.intel.com ([134.134.136.18]:26024 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750776AbWCQQxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:53:16 -0500
Message-ID: <441AE971.8040907@linux.intel.com>
Date: Fri, 17 Mar 2006 17:53:05 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/8] Port of -fstack-protector to the kernel
References: <1142611850.3033.100.camel@laptopd505.fenrus.org> <6bffcb0e0603170850i5f955151v@mail.gmail.com>
In-Reply-To: <6bffcb0e0603170850i5f955151v@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski wrote:
> Hi,
> 
> On 17/03/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
>> This patch series adds support for the gcc 4.1 -fstack-protector feature to
>> the kernel. Unfortunately this needs a gcc patch before it can work, so at
>> this point these patches are just for comment, not for merging.
>>
> 
> It's x86_64 specific?

for now it is yes; x86-64 is the "easiest" one because there already is a
per-processor datastructure in line with what gcc expect (eg similar to the
userland per thread structure). For x86... that's not there in the kernel.

