Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbUB0AL2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbUB0AL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:11:27 -0500
Received: from smtp06.auna.com ([62.81.186.16]:30154 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261390AbUB0ALV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:11:21 -0500
Date: Fri, 27 Feb 2004 01:11:15 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.3-mm4
Message-ID: <20040227001115.GA2627@werewolf.able.es>
References: <20040225185536.57b56716.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040225185536.57b56716.akpm@osdl.org> (from akpm@osdl.org on Thu, Feb 26, 2004 at 03:55:36 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.26, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm4/
> 
> - Big knfsd update.  Mainly for nfsv4
> 
> - DVB udpate
> 
> - Various fixes
> 

As somebody also stated, there are problems with sensors:

werewolf:~# service lm_sensors start
Loading sensors modules: 
w83781d-isa-0290: Can't access procfs/sysfs file for writing;
Run as root?
Starting sensord:                                               [  OK  ]

I _was_ root. And initscripts are run as root ?

Perhaps this is a more generic problem with sysfs :(.

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (RC1) for i586
Linux 2.6.3-jam4 (gcc 3.4.0 (Mandrake Linux 10.0 3.4.0-0.2mdk))
