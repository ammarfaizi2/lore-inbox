Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTFDDbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 23:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTFDDbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 23:31:51 -0400
Received: from sccrmhc11.attbi.com ([204.127.202.55]:6885 "EHLO
	sccrmhc11.attbi.com") by vger.kernel.org with ESMTP id S262703AbTFDDbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 23:31:49 -0400
Message-ID: <3EDD6B51.9070909@osdl.org>
Date: Tue, 03 Jun 2003 20:45:21 -0700
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: Regarding SET_NETDEV_DEV
References: <20030603175921.GE2079@gtf.org> <20030603.200944.78736971.davem@redhat.com>
In-Reply-To: <20030603.200944.78736971.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>   From: Jeff Garzik <jgarzik@pobox.com>
>   Date: Tue, 3 Jun 2003 13:59:21 -0400
>
>   For janitors and other developers placing this in net drivers...
>   please don't :)  This can be done in upper layers, accomplishing the
>   same goal without changing the low-level net driver code at all.
>   
>Don't say something can be done without showing exactly
>how :-)
>
>How does register_netdevice() know that the device is "whatever" and
>where to get the generic device struct from?
>
There are enough PCI network devices, that something like 
alloc_pci_etherdev might
be a good future idea.


