Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWDEB0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWDEB0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 21:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWDEB0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 21:26:09 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:51169 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751063AbWDEB0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 21:26:07 -0400
Date: Wed, 5 Apr 2006 10:27:33 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: ebiederm@xmission.com, khalid_aziz@hp.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org, linux-ia64@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kexec on ia64
Message-Id: <20060405102733.eabc00fe.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <08B1877B2880CE42811294894F33AD5C053A85@pdsmsx411.ccr.corp.intel.com>
References: <08B1877B2880CE42811294894F33AD5C053A85@pdsmsx411.ccr.corp.intel.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2006 09:13:36 +0800
"Zou, Nanhai" <nanhai.zou@intel.com> wrote:
> > I'm working for memory hotplug. When memory is hot-added, memory layout
> > changes.
> > But I think there is no code to manage memory layout information of added memory.
> > 
>  It reads memory layout from /proc/iomem...,
>  If memory is hotpluged, I think we need a reload of kdump.
> 
If /proc/iomem is updated at hotplug event (this is not updated now),
is there no problem ?

calling insert_resource like  efi_initialize_iomem_resources() is good ?

-Kame

