Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUEJFpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUEJFpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 01:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264529AbUEJFpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 01:45:55 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:22451 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264524AbUEJFpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 01:45:52 -0400
Subject: Re: [ANNOUNCE] [PATCH] Node Hotplug Support
From: Dave Hansen <haveblue@us.ibm.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hotplug devel <linux-hotplug-devel@lists.sourceforge.net>,
       lhns-devel@lists.sourceforge.net
In-Reply-To: <20040510104725.7c9231ee.tokunaga.keiich@jp.fujitsu.com>
References: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
	 <1083944945.23559.1.camel@nighthawk>
	 <20040510104725.7c9231ee.tokunaga.keiich@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1084167941.28602.478.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 09 May 2004 22:45:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-05-09 at 18:47, Keiichiro Tokunaga wrote:
> There is no NUMA support in the current code yet.  I'll post a
> rough patch to show my idea soon.  I'm thinking to regard a
> container device that has PXM as a NUMA node so far.

Don't you think it would be a good idea to work with some of the current
code, instead of trying to wrap around it?  

I'm sure Matt Dobson can give you some great ideas about things in the
current NUMA code that aren't hotplug safe.  That really needs to be
done before any other work, anyway.  

-- Dave

