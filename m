Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWF2O65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWF2O65 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 10:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWF2O65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 10:58:57 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:49577 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750716AbWF2O64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 10:58:56 -0400
Subject: Re: [PATCH] solve config broken: undefined reference to
	`online_page'
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Toralf Foerster <toralf.foerster@gmx.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <20060629114417.2A02.Y-GOTO@jp.fujitsu.com>
References: <44A1204F.3070704@shadowen.org>
	 <20060628110338.9B6A.Y-GOTO@jp.fujitsu.com>
	 <20060629114417.2A02.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 07:58:31 -0700
Message-Id: <1151593112.1553.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-29 at 12:21 +0900, Yasunori Goto wrote:
> Hi Andrew-san.
> 
> I made a small patch for compile error of 2.6.17(.1).
> If CONFIG_HIGHMEM is not set and CONFIG_MEMORY_HOTPLUG is set on i386
> box, the trouble occurs. Its trouble report is here.
> http://marc.theaimsgroup.com/?t=115104987100003&r=1&w=2
> 
> At first, I wanted to send stable kernel which is 2.6.17.x.
> But, Documentation/stable_kernel_rules.txt says that config
> broken trouble is not acceptable for it. So, I would like to send
> this to 2.6.18-rcX.
> 
> Please apply.

Acked-by: Dave Hansen <haveblue@us.ibm.com>

-- Dave

