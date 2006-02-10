Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWBJRQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWBJRQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWBJRQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:16:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:44463 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751331AbWBJRQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:16:12 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [RFC/PATCH: 004/010] Memory hotplug for new nodes with pgdat allocation. (pgdat alloc caller for x86_64)
Date: Fri, 10 Feb 2006 18:15:12 +0100
User-Agent: KMail/1.8.2
Cc: Yasunori Goto <y-goto@jp.fujitsu.com>, "Luck, Tony" <tony.luck@intel.com>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
References: <20060210224257.C536.Y-GOTO@jp.fujitsu.com>
In-Reply-To: <20060210224257.C536.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101815.12914.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 15:21, Yasunori Goto wrote:
> This is sample code of calling pgdat allocation function for x86_64.
> Basically it is same with ia64. 
> 
> I've not tried this patch yet, due to I couldn't make emulation for
> new node addtion for x86_64. This is just to reference. :-P

Looks ok basically assuming someone tests it

(I guess it would be possible to hack the numa emulation to support
hotplug) 

-Andi
