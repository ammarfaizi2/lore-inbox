Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWBQQAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWBQQAj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWBQQAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:00:38 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:39904 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932384AbWBQQAi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:00:38 -0500
Subject: Re: [PATCH] change memoryX->phys_device from number to symlink
	[1/2] generic func
From: Dave Hansen <haveblue@us.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       Yasunori Goto <y-goto@jp.fujitsu.com>,
       lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <43F570B1.7050302@jp.fujitsu.com>
References: <43F570B1.7050302@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 07:59:56 -0800
Message-Id: <1140191996.21383.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-17 at 15:44 +0900, KAMEZAWA Hiroyuki wrote:
> This patch is from memory hotplug tree in lhms.
> This patch changes memory_device's phys_device member from just a
> number
> to symbolic link to the device. AFAIK, phys_device is not used now. 

We meant to use it for hardware which did not nicely export its
information in sysfs.  But, it seems reasonable now to say that, if you
want this file to mean anything on your hardware, export your hardware
in sysfs.  

As you said, I don't think anybody uses this yet.

-- Dave

