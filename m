Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263285AbTDCGJ4>; Thu, 3 Apr 2003 01:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263287AbTDCGJ4>; Thu, 3 Apr 2003 01:09:56 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:2762 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S263285AbTDCGJz>; Thu, 3 Apr 2003 01:09:55 -0500
Message-ID: <3E8BD2D9.8050002@attbi.com>
Date: Thu, 03 Apr 2003 01:21:13 -0500
From: Albert Cranford <ac9410@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] More i2c driver changes for 2.5.66
References: <1049328958830@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I read the thread concerning the removal of proc.c & proc.h
but hope that this does not go to Linus until the interface
between i2c & sensors to application is somewhat defined.

At the moment we have a sysctl API used by sensors, video and
other i2c kernel applications that is working.
Our desire to switch the sensors to sysfs interface should not
break other applications.  At least until we have a model/api
to propose to these other drivers.

In my personal home systems I use it87 driver and have been
somewhat successful in switching to sysfs.  A big blocking
point is there is no application to read/set/monitor the
driver, so it is basically unverified.  I would hate to
put other i2c applications in the same boat.
Your thoughts?
Albert

Greg KH wrote:
> ChangeSet 1.977.29.8, 2003/04/02 11:45:21-08:00, greg@kroah.com
> 
> i2c: remove proc and sysctl code from i2c-proc as it is no longer used.
>

