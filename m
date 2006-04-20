Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWDTRHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWDTRHv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWDTRHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:07:08 -0400
Received: from fmr19.intel.com ([134.134.136.18]:4739 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751163AbWDTRGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:06:42 -0400
Message-ID: <4447BF98.4020806@linux.intel.com>
Date: Thu, 20 Apr 2006 21:06:32 +0400
From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Xavier Bestel <xavier.bestel@free.fr>, "Yu, Luming" <luming.yu@intel.com>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com> <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <1145549460.23837.156.camel@capoeira> <4447B7D6.4030401@linux.intel.com> <20060420164419.GA30317@srcf.ucam.org> <4447BB2B.1060407@linux.intel.com> <20060420165515.GA30415@srcf.ucam.org>
In-Reply-To: <20060420165515.GA30415@srcf.ucam.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> On Thu, Apr 20, 2006 at 08:47:39PM +0400, Alexey Starikovskiy wrote:
> 
>> Yes, this is why I mentioned using kevent and dbus before... Could it be 
>> the righter answer?
> 
> I think it makes sense for atkbd and usb hid power and sleep buttons to 
> be treated like all other keys on those keyboard types. As a result, I 
> think it makes sense for ACPI keys to behave in the same way. I wrote an 
> addon for hal to take input events and put them on the system dbus some 
> time ago, so that's already a solved problem.
> 
So now you can do a shortcut and send ACPI events to dbus without involving input layer and hal.
