Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbTFJP7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTFJP7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:59:31 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:41585 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S263245AbTFJP7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:59:30 -0400
Message-ID: <3EE60262.6070202@rackable.com>
Date: Tue, 10 Jun 2003 09:08:02 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Zhu <mylinuxk@yahoo.ca>
CC: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: about bdflush
References: <20030610155532.35065.qmail@web14914.mail.yahoo.com>
In-Reply-To: <20030610155532.35065.qmail@web14914.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2003 16:13:07.0205 (UTC) FILETIME=[2DBFB350:01C32F6B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Zhu wrote:

>Hi, guys, I have a small question about
>/proc/sys/vm/bdflush . I am working on a SMP machine.
>The kernel version is 2.4.18. I want to modify the
>content of /proc/sys/vm/bdflush. But once I modify the
>content, it will go back to the default value after I
>reboot the OS. Is there a way by which I can
>permanently change the content of this file? The OS
>keeps the default value in somewhere? 
>
>Thanks in advance.
>  
>

  Either change the default in the source and recompile your kernel, or 
set it at boot in /etc/rc.local.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


