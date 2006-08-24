Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWHXXYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWHXXYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 19:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbWHXXYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 19:24:08 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:22444 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030299AbWHXXYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 19:24:06 -0400
Message-ID: <44EE3515.6000304@vmware.com>
Date: Thu, 24 Aug 2006 16:24:05 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove default_ldt, and simplify ldt-setting.
References: <44EE308B.8000304@goop.org> <200608250115.36879.ak@suse.de>
In-Reply-To: <200608250115.36879.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>
>> If there are no LDT entries, the LDT register is loaded
>> with a NULL descriptor.
>>     
>
> x86-64 currently doesn't do this -- do you see an particular advantage 
> in it?
>   

It's friendlier to virtual machines ;)  And you can't get a zero sized 
LDT otherwise.
