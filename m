Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269338AbUHaXu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269338AbUHaXu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUHaXsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:48:12 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:23236 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S269162AbUHaXfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:35:06 -0400
Message-ID: <41350B28.30700@blueyonder.co.uk>
Date: Wed, 01 Sep 2004 00:35:04 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jason@stdbev.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm2 nvidia breakage
References: <4134A5EE.5090003@blueyonder.co.uk> <d40d2dbcd4c9aaaeb94073ca00d7b3b7@stdbev.com>
In-Reply-To: <d40d2dbcd4c9aaaeb94073ca00d7b3b7@stdbev.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Aug 2004 23:35:28.0824 (UTC) FILETIME=[32D95B80:01C48FB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Munro wrote:

>On 11:23:10 am 2004-08-31 Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>nvidia-installer log file '/var/log/nvidia-installer.log'
>creation time: Tue Aug 31 17:05:05 2004
>
>[snip]
>
>   `PM_SAVE_STATE' undeclared (first use in this function)
>   /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv.c:3697:
>
>
>A patch was posted a week or so ago to fix this which works for me.
>
>http://lkml.org/lkml/2004/8/20/209
>  
>
Oops, built from a new tree and forgot I hadn't made the change.

>I also had to change calls to pci_find_class in nv.c to pci_get_class to
>get the module to load with 2.6.9-rc1-mm2.
>
>  
>
Module builds and installs with the changes, but switches to a blank 
screen on KDE 3.3.0 SuSE 9.1.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====

