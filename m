Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbUJ0GgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbUJ0GgL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbUJ0Gcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:32:50 -0400
Received: from fmr01.intel.com ([192.55.52.18]:19421 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262299AbUJ0GbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:31:06 -0400
Message-ID: <417F409A.5060409@intel.com>
Date: Wed, 27 Oct 2004 02:30:50 -0400
From: Len Brown <len.brown@intel.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
To: Li Shaohua <shaohua.li@intel.com>
CC: Pavel Machek <pavel@ucw.cz>, ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, greg@kroah.com
Subject: Re: [ACPI] Re: [Proposal]Another way to save/restore PCI config space
 for suspend/resume
References: <fa.fvou17m.1f5oa9u@ifi.uio.no> <fa.ivj042g.g5qnoo@ifi.uio.no>
In-Reply-To: <fa.ivj042g.g5qnoo@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Li Shaohua wrote:
> On Tue, 2004-10-26 at 17:21, Pavel Machek wrote:

>>>Here is a another idea: 
>>>Record all PCI writes in Linux kernel...
>>
>>That looks extremely ugly to me. If you want to do something special
>>in resume function, just do it there. It will probably share a lot of
>>code with your init function, anyway.
> 
> How can you handle devices without driver? And how to save/restore
> config space for special devices, such as LPC bridge and host bridge?

Say that writing the missing drivers is the only workable solution.
Does anybody have an estimate of how many there are and how big
a task that would be?

-Len
