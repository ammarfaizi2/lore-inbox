Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbUCVQY4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 11:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbUCVQY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 11:24:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:42702 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262088AbUCVQYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 11:24:55 -0500
Message-Id: <200403221624.i2MGOfE10217@mail.osdl.org>
Date: Mon, 22 Mar 2004 08:24:36 -0800 (PST)
From: markw@osdl.org
Subject: Re: 2.6.4-mm2
To: piggin@cyberone.com.au
cc: len.brown@intel.com, akpm@osdl.org, axboe@suse.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <405C0873.6080805@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Mar, Nick Piggin wrote:
> 
> 
> Len Brown wrote:
> 
>>On Fri, 2004-03-19 at 23:19, Brown, Len wrote:
>>
>>>CONFIG_X86_HT=y does not enable HT.
>>>CONFIG_X86_HT=n does not disable HT.
>>>It only controls if the cpu_sibling_map[] etc. are initialized.
>>>
>>>acpi=off does not disable HT
>>>
>>
>>oops, that line incorrect.
>>we fixed "acpi=off" to _really_ mean ACPI off -- table parsing
>>and all, so it does disable HT, along w/ all the other stuff
>>that depends on ACPI.
>>
>>
> 
> So how come oprofile seems to think there is a sibling?
> Can you verify both cases use physical only CPUs?

The sar output still only lists data for 4 individual CPUs.  Is that a
good way to verify it?
