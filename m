Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVDLMHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVDLMHq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVDLMGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:06:24 -0400
Received: from 70-56-217-9.albq.qwest.net ([70.56.217.9]:5259 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262366AbVDLMGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:06:06 -0400
Date: Tue, 12 Apr 2005 06:07:46 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Li Shaohua <shaohua.li@intel.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Ryan Harper <ryanh@us.ibm.com>
Subject: Re: [PATCH 1/6]sep initializing rework
In-Reply-To: <1113283845.27646.424.camel@sli10-desk.sh.intel.com>
Message-ID: <Pine.LNX.4.61.0504120558500.14171@montezuma.fsmlabs.com>
References: <1113283845.27646.424.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shaohua,

On Tue, 12 Apr 2005, Li Shaohua wrote:

> These patches (together with 5 patches followed this one) are updated
> suspend/resume SMP patches. The patches fixed some bugs and do clean up
> as suggested. Now they work for both suspend-to-ram and suspend-to-disk.
> Patches are against 2.6.12-rc2-mm3.

These patches look good and i think we should go ahead with them. I've 
also cross checked with physical hotplug cpu patches for ES7xxx from 
Natalie (added to Cc) and it does indeed look like a lot of the code will 
work for her too, but i'd appreciate it if she also does a double check. 
Obviously this won't work for other upcoming users of hotplug cpu like Xen 
(Ryan added to Cc) but i think we can abstract things later on to cover 
other special users.

Thanks Shaohua,
	Zwane

