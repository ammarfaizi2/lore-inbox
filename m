Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWBKDHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWBKDHF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 22:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWBKDHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 22:07:05 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:37256 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932137AbWBKDHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 22:07:01 -0500
Date: Sat, 11 Feb 2006 12:06:11 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [Lhms-devel] [RFC/PATCH: 001/010] Memory hotplug for new nodes with pgdat allocation. (pgdat allocation)
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       x86-64 Discuss <discuss@x86-64.org>
In-Reply-To: <1139588910.9209.73.camel@localhost.localdomain>
References: <20060210223757.C530.Y-GOTO@jp.fujitsu.com> <1139588910.9209.73.camel@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060211120325.D358.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2006-02-10 at 23:20 +0900, Yasunori Goto wrote:
> > +        unsigned long size = arch_pernode_size(nid); 
> 
> Size in what?  Pages?  Bytes?  Meters? :)

Do you mean variable name is not appropriate?

Then, I'll change it to pernode_size, pernode_struct_size or
something. :-)

-- 
Yasunori Goto 


