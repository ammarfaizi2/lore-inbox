Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbULOInw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbULOInw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 03:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbULOInw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 03:43:52 -0500
Received: from mail.outpost24.com ([212.214.12.146]:56005 "EHLO
	klippan.outpost24.com") by vger.kernel.org with ESMTP
	id S261785AbULOInt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 03:43:49 -0500
Message-ID: <41BFF931.6030205@outpost24.com>
Date: Wed, 15 Dec 2004 09:43:29 +0100
From: David Jacoby <dj@outpost24.com>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux kernel IGMP vulnerabilities
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi and Merry Xmas everyone!


I just have a little question, is there a way to turn on IGMP support in 
the kernel?, I removed
multicast support but is that enugh?

They said that you could see if you are vulnerable by looking at these 
files:

/proc/net/igmp
/proc/net/mcfilter

and if both existed and were non-emptu you were vulnerable.


On a defualt installation on Slackware 10 the files mcfilter
is empty but on other servers with various kernel versions
both files contains some data.

The slackware machine is running 2.4.24. As i said i removed
multicast support in the kernel but when i compiled it i saw
that it created igmp.o anyway.


Any advice about how people can patch this security issue?


Thnx!

//David



-- 
Outpost24 AB

David Jacoby
Research & Development

Office: +46-455-612310
Mobile: +46-455-612311
(www.outpost24.com) (dj@outpost24.com) 

