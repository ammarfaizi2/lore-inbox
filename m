Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbTFCFyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 01:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264935AbTFCFyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 01:54:52 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:49562 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP id S264929AbTFCFyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 01:54:52 -0400
Message-ID: <3EDC3B52.6030604@attbi.com>
Date: Mon, 02 Jun 2003 23:08:18 -0700
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk7 -- drivers/net/irda/w83977af_ir.ko needs unknown	symbol
 setup_dma
References: <3EDBCC44.8000009@attbi.com> <1054612898.9352.3.camel@rth.ninka.net>
In-Reply-To: <1054612898.9352.3.camel@rth.ninka.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Mon, 2003-06-02 at 15:14, Miles Lane wrote:
> 
>>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.70-bk7; fi
>>WARNING: /lib/modules/2.5.70-bk7/kernel/drivers/net/irda/w83977af_ir.ko 
>>needs unknown symbol setup_dma
> 
> 
> What platform is this?  It needs to set CONFIG_ISA correctly.

It's PPC.

CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_6xx=y

#
# General setup
#
# CONFIG_HIGHMEM is not set
# CONFIG_ISA is not set
CONFIG_PCI=y



