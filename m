Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264444AbUEJBsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUEJBsP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 21:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbUEJBsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 21:48:15 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:54500 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264444AbUEJBsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 21:48:14 -0400
Date: Mon, 10 May 2004 10:47:25 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [ANNOUNCE] [PATCH] Node Hotplug Support
In-reply-to: <1083944945.23559.1.camel@nighthawk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net
Message-id: <20040510104725.7c9231ee.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
 <1083944945.23559.1.camel@nighthawk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 May 2004 08:49:05 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> On Fri, 2004-05-07 at 08:39, Keiichiro Tokunaga wrote:
> > First of all, I'd like to discuss the design of node hotplug and
> > interface with hotplug folks.  After I get feedback from the people,
> > I'll update my patches.  Also I'll release the following features in
> > the near future.  Then I'll make them work all together and test
> > them.
> > 
> >   - NUMA node support
> >   - ACPI based memory hotplug
> >   - ACPI based IO hotplug
> >   - H2P bridge hotplug
> >   - P2P brdige hotplug
> >   - IOSAPIC hotplug
> 
> How does this interoperate with the current NUMA topology already in
> sysfs today?  I don't see any references at all to the current code.  

There is no NUMA support in the current code yet.  I'll post a
rough patch to show my idea soon.  I'm thinking to regard a
container device that has PXM as a NUMA node so far.

Thanks,
Kei
