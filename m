Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266468AbUFUVLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266468AbUFUVLm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 17:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266469AbUFUVLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 17:11:41 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:9358 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266471AbUFUVLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 17:11:31 -0400
Message-ID: <40D74EFE.1000500@nortelnetworks.com>
Date: Mon, 21 Jun 2004 17:11:26 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: BUG?:   G5 not using all available memory
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got a G5 with 2GB of memory, running 2.6.7, ppc architecture (not ppc64), 
with the following config options (let me know if others are relevent)

# CONFIG_CMDLINE_BOOL is not set
#
# Advanced setup
#
CONFIG_ADVANCED_OPTIONS=y
# CONFIG_HIGHMEM_START_BOOL is not set
CONFIG_HIGHMEM_START=0xfe000000
# CONFIG_LOWMEM_SIZE_BOOL is not set
CONFIG_LOWMEM_SIZE=0x30000000
# CONFIG_KERNEL_START_BOOL is not set
CONFIG_KERNEL_START=0xc0000000

After boot, I get the following output in dmesg:

Memory: 510080k available (3144k kernel code, 1532k data, 168k init, 0k highmem)


What's going on?  Why can't I see all my memory?

Chris
