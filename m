Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275648AbTHOCs4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 22:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275643AbTHOCs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 22:48:56 -0400
Received: from main.gmane.org ([80.91.224.249]:60345 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S275648AbTHOCsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 22:48:55 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Charles Lepple <clepple@ghz.cc>
Subject: Re: finding which pci device works as ide controller for root fs
Date: Thu, 14 Aug 2003 22:39:22 -0400
Message-ID: <bhhh4r$n16$1@sea.gmane.org>
References: <200308141826.30735.arekm@pld-linux.org> <20030815001552.GA4776@kroah.com> <200308150238.30618.arekm@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
In-Reply-To: <200308150238.30618.arekm@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arkadiusz Miskiewicz wrote:
> On Friday 15 of August 2003 02:15, Greg KH wrote:
> 
>>On Thu, Aug 14, 2003 at 06:26:30PM +0200, Arkadiusz Miskiewicz wrote:
>>
>>>[arekm@mobarm arekm]$ ls -l /sys/block/hda/device
>>>lrwxrwxrwx    1 root     root           46 2003-08-14 00:49
>>>/sys/block/hda/device -> ../../devices/pci0000:00/0000:00:11.1/ide0/0.0
>>>
>>>Is it possible to get PCI ID from sysfs for specified device?
>>
>>It's right there in the path to the ide device "0000:00:11.1"
> 
> How's that related to awk ' { print $2 } ' /proc/bus/pci/devices?

If you're looking for the vendor and product IDs, they're in 
/sys/devices/pci..../..../{vendor,device}

-- 
Charles Lepple <ghz.cc!clepple>


