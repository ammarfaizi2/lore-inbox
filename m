Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbUEMB25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUEMB25 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 21:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUEMB25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 21:28:57 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:27618 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261907AbUEMB2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 21:28:54 -0400
Date: Thu, 13 May 2004 10:27:51 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [ANNOUNCE] [PATCH] Node Hotplug Support
In-reply-to: <1084167941.28602.478.camel@nighthawk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: tokunaga.keiich@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net
Message-id: <20040513102751.48c61d48.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
 <1083944945.23559.1.camel@nighthawk>
 <20040510104725.7c9231ee.tokunaga.keiich@jp.fujitsu.com>
 <1084167941.28602.478.camel@nighthawk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 May 2004 22:45:42 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> On Sun, 2004-05-09 at 18:47, Keiichiro Tokunaga wrote:
> > There is no NUMA support in the current code yet.  I'll post a
> > rough patch to show my idea soon.  I'm thinking to regard a
> > container device that has PXM as a NUMA node so far.
> 
> Don't you think it would be a good idea to work with some of the current
> code, instead of trying to wrap around it?  

Are you saying that LHNS should use the current NUMA code
(or coming code in the future) to support NUMA node hotplug?

> I'm sure Matt Dobson can give you some great ideas about things in the
> current NUMA code that aren't hotplug safe.  That really needs to be
> done before any other work, anyway.  

Thanks,
Kei
