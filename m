Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263872AbUCZAhJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbUCZAgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:36:44 -0500
Received: from 65.104.119.60.ptr.us.xo.net ([65.104.119.60]:10135 "EHLO
	dns1.appliedminds.com") by vger.kernel.org with ESMTP
	id S263872AbUCZAdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:33:07 -0500
Message-ID: <40637A42.4080603@appliedminds.com>
Date: Thu, 25 Mar 2004 16:33:06 -0800
From: James Lamanna <jamesl@appliedminds.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Figuring out USB device locations
References: <406314EF.7040304@appliedminds.com> <20040325235740.GA30964@kroah.com>
In-Reply-To: <20040325235740.GA30964@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Mar 2004 00:33:05.0627 (UTC) FILETIME=[E79562B0:01C412C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> On Thu, Mar 25, 2004 at 09:20:47AM -0800, James Lamanna wrote:
> 
>>Is there an easy way to find out what /dev entries usb devices get 
>>mapped to from userspace?
> 
> 
> "easy way" on 2.4?  No, sorry.  You need 2.6 to determine this in a
> simple manner.  But there are some files in the /proc/bus/usb/
> and /proc/bus/input/ directories that will help you out.

Hmm...its not obvious to me how i can use /proc/bus/usb/xxx/yyy to get 
the /dev entry information. I can get the USB device number, but I don't 
see how to get at a mapping to a major/minor in /dev space (or is this 
not possible in 2.4)...

-- 
James Lamanna
