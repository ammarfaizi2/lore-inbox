Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264148AbTDWRSe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264149AbTDWRSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:18:34 -0400
Received: from lakemtao04.cox.net ([68.1.17.241]:42486 "EHLO
	lakemtao04.cox.net") by vger.kernel.org with ESMTP id S264148AbTDWRSd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:18:33 -0400
Message-ID: <3EA6CDB0.8050905@cox.net>
Date: Wed, 23 Apr 2003 12:30:24 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-rc1] USB Trackball broken
References: <3EA6C558.5040004@cox.net> <20030423172135.GA11572@kroah.com>
In-Reply-To: <20030423172135.GA11572@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Apr 23, 2003 at 11:54:48AM -0500, David van Hoose wrote:
> 
>>I am running RedHat 9. Trackball is detected and works when using the 
>>stock 2.4.20-9 kernel that RedHat provided.
>>
>>With 2.4.21-rc1, I have included the USB and input devices in the 
>>kernel, as modules, and as various combinations in between. My USB 
>>Logitech Trackball shows up as being detected and setup, but it doesn't 
>>work. Attached is my config and a trimmed down dmesg. (ppa is messed up 
>>and floods me with messages)
>>I have USB vebose debugging turned on. That may help. Please let me know 
>>what information you might need in addition.
> 
> 
> Is this trackball plugged into a USB 2.0 hub or controller?
> 
> If you cat /dev/input/mice and move the trackball around, do you get
> data?

Under the RedHat kernel, I get data.
Under the 2.4.21-rc1 kernel, I get nothing.

Thanks,
David

