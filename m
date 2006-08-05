Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWHEWws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWHEWws (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 18:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWHEWwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 18:52:47 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:13255 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750906AbWHEWwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 18:52:47 -0400
Message-ID: <44D5213E.3000900@vmware.com>
Date: Sat, 05 Aug 2006 15:52:46 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: jeremy@xensource.com, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       jeremy@goop.org, chrisw@sous-sol.org
Subject: Re: [patch 7/8] Add a bootparameter to reserve high linear address
 space.
References: <20060803002510.634721860@xensource.com>	<20060803002518.595166293@xensource.com>	<20060802231912.ed77f930.akpm@osdl.org>	<44D1A6B6.8040003@vmware.com>	<20060803004144.554d9882.akpm@osdl.org>	<44D1BAB8.8070509@vmware.com> <20060805145840.653912a2.akpm@osdl.org>
In-Reply-To: <20060805145840.653912a2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 03 Aug 2006 01:58:32 -0700
> Zachary Amsden <zach@vmware.com> wrote:
>
>   
>> Add a bootparameter to reserve high linear address space for hypervisors.
>> This is necessary to allow dynamically loaded hypervisor modules, which
>> might not happen until userspace is already running, and also provides a
>> useful tool to benchmark the performance impact of reduced lowmem address
>> space.
>>     
>
> Andi has gone and rotorooted the x86 boot parameter handling in there. 
> This patch now looks like this:
>   

The rototilled patch looks great.  Acked.

Zach
