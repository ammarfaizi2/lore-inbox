Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262970AbVCDSes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbVCDSes (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 13:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbVCDSep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 13:34:45 -0500
Received: from smartmx-05.inode.at ([213.229.60.37]:17549 "EHLO
	smartmx-05.inode.at") by vger.kernel.org with ESMTP id S262970AbVCDSb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:31:59 -0500
Message-ID: <4228A9A1.2090301@inode.info>
Date: Fri, 04 Mar 2005 19:32:01 +0100
From: Richard Fuchs <richard.fuchs@inode.info>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: slab corruption in skb allocs
References: <42283093.7040405@inode.info> <20050304181050.GB4484@redhat.com>
In-Reply-To: <20050304181050.GB4484@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> Which network drivers are in use on the box that gets the corruption ?

all three that i tested it on are using the e100 driver. the boxes with 
pci id 8086:1039 and 8086:1229 are seeing corruptions, the one with pci 
id 8086:2449 is not.

i will try again the eepro100 driver and see if it does the same...

cheers
richard
