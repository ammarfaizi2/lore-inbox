Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWEQFf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWEQFf3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 01:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWEQFf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 01:35:29 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:62347 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932146AbWEQFf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 01:35:29 -0400
Date: Wed, 17 May 2006 14:37:37 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: nacc@us.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       y-goto@jp.fujitsu.com
Subject: Re: [PATCH] typo in i386/init.c [BugMe #6538]
Message-Id: <20060517143737.09498464.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1147801216.6623.114.camel@localhost.localdomain>
References: <20060516165040.GA4341@us.ibm.com>
	<20060516102427.2c50d469.akpm@osdl.org>
	<20060516173421.GB4341@us.ibm.com>
	<1147801216.6623.114.camel@localhost.localdomain>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006 10:40:16 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> On Tue, 2006-05-16 at 10:34 -0700, Nishanth Aravamudan wrote:
> > > So there's something fishy going on here.
> > 
> > I won't deny that :)
> 
> I think the fishiness probably comes from the apparent fact that nobody
> besides me ever enabled sparsemem, then memory hotplug on x86.  

I usually enable CONFIG_MEMORY_HOTPLUG + CONFIG_SPARSEMEM and test it. 
Then I sent a patch in past ;)

But I wonder usual x86 men will never use memory hot-add until memory
hot-remove is implemented. 
-Kame


