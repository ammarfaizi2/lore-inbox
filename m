Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWBJBuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWBJBuO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 20:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWBJBuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 20:50:14 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:12437 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750971AbWBJBuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 20:50:12 -0500
Date: Fri, 10 Feb 2006 10:49:06 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [Lhms-devel] [RFC:PATCH(000/003)] Memory add to onlined node. (ver. 2)
Cc: "Andi Kleen" <ak@suse.de>, "Brown, Len" <len.brown@intel.com>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       "S, Naveen B" <naveen.b.s@intel.com>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "ACPI-ML" <linux-acpi@vger.kernel.org>,
       "Linux Kernel ML" <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>, "x86-64 Discuss" <discuss@x86-64.org>,
       "Linux Hotplug Memory Support" <lhms-devel@lists.sourceforge.net>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F05AA16C3@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05AA16C3@scsmsx401.amr.corp.intel.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060210103730.AFC7.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > - if the node is already online.-  If the node is offline, 
> > (It means new node is comming!)  then the memory will belongs
> > to node 0 yet.
> 
> What is the long term plan to address this?  Can you make sure
> that the new node is always brought online before you get to
> this code?  Or will you have to bring the node online in the
> middle of the memory hot-add code?

I still have patches for new pgdat addtion,
But I was afraid that everyone think they are messy due to too much code.
So, I tried to post a part of them step by step.

Ok, I would like to try to rebase and repost them.
It might be good time for it now. :-)

Bye.
-- 
Yasunori Goto 


