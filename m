Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbUB0RKY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 12:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbUB0RKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 12:10:19 -0500
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:64656 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S263056AbUB0RJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 12:09:37 -0500
Message-ID: <403F79CB.3050902@backtobasicsmgmt.com>
Date: Fri, 27 Feb 2004 10:09:31 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: S390 block devs on !s390.
References: <20040227135728.GA15016@redhat.com> <403F7431.80608@backtobasicsmgmt.com> <20040227165826.GA9352@redhat.com> <20040227170246.GC15016@redhat.com>
In-Reply-To: <20040227170246.GC15016@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> --- linux-2.6.3/drivers/s390/block/Kconfig~	2004-02-27 17:00:07.000000000 +0000
> +++ linux-2.6.3/drivers/s390/block/Kconfig	2004-02-27 17:00:27.000000000 +0000
> @@ -1,3 +1,5 @@
> +if ARCH_S390
> +
>  comment "S/390 block device drivers"
>  	depends on ARCH_S390
                     ^^^
But this is now redundant :-)

