Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268800AbUIADGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268800AbUIADGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 23:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268878AbUIADGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 23:06:24 -0400
Received: from mta11.adelphia.net ([68.168.78.205]:4329 "EHLO
	mta11.adelphia.net") by vger.kernel.org with ESMTP id S268800AbUIADGU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 23:06:20 -0400
Message-ID: <41353C7F.8040509@nodivisions.com>
Date: Tue, 31 Aug 2004 23:05:35 -0400
From: Anthony DiSante <orders@nodivisions.com>
Reply-To: orders@nodivisions.com
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: devfsd stuck in D state
References: <41353913.70102@nodivisions.com> <1094007399.3404.51.camel@krustophenia.net>
In-Reply-To: <1094007399.3404.51.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2004-08-31 at 22:50, Anthony DiSante wrote:
> 
>>Hello,
>>
>>I'm running devfs v1.22 on this Gentoo system:
>>
> 
> 
> Are you sure hotplug is enabled?  Is there an OOPS?

hotplug is enabled in the kernel (compiled-in, not modular) and here's what 
I have:

[2302][~]# cat /proc/sys/kernel/hotplug
/sbin/hotplug
[2302][~]# /sbin/hotplug
Usage: /etc/hotplug.d/default/default.hotplug AgentName [AgentArguments]
AgentName values on this system:  dasd firmware ieee1394 input net pci scsi 
tape usb
[2302][~]#

And there's no oops in /var/log/messages or in dmesg.  Is there anywhere 
else it'd show up?

Thanks,
Anthony
http://nodivisions.com/
