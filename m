Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUCFPko (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 10:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUCFPko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 10:40:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3986 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261681AbUCFPkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 10:40:42 -0500
Message-ID: <4049F0EE.7060501@pobox.com>
Date: Sat, 06 Mar 2004 10:40:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hyper-threaded pickle
References: <40480795.5000402@pobox.com> <1078469072.12990.1742.camel@dhcppc4>
In-Reply-To: <1078469072.12990.1742.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> Re: old systems -- we use dmi_scan to disable ACPI on systems by default
> on systems older than 1/1/2001.

What happens for the no-DMI case?


> Re: opteron & !HT.  Andi showed me a patch today that disables X86_HT if
> you build specifically for an AMD CPU that doesn't support HT.  This
> looks like a good idea, and possibly should be expanded.

Cool.

My main worry/concern is breaking older systems, due to this change in 
behavior.

An easy first step is to make CONFIG_X86_HT selectable again.

	Jeff



