Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263643AbSJHUW3>; Tue, 8 Oct 2002 16:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbSJHUVY>; Tue, 8 Oct 2002 16:21:24 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:13662 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S263267AbSJHUU3>;
	Tue, 8 Oct 2002 16:20:29 -0400
Message-ID: <3DA33F70.7050504@acm.org>
Date: Tue, 08 Oct 2002 15:26:24 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IPMI driver for Linux, version 4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have put a new version of the IPMI driver on my home page 
(http://home.attbi.com/~minyard) that fixes a bug.  A previous 
unannounce version is there (v3) that adds IPMB broadcast support and 
fixes a bug.  If you are using this driver, you want to update to the 
newest version.  These are only supplied as a patches against the 
previous version since the patches are small and apply to all kernel 
versions.  If someone wants a full patch, I can do that, too.

I was toying with the idea of adding a socket interface to the IPMI 
driver.  This way, it would naturally handle separation of addressing 
and data, and it wouldn't take up a character device.  I think I could 
map everything the driver does into standard network calls, and the IPMB 
bus is sort of a network, anyway.  Does anyone have any opinions on this?

-Corey

PS - In case you don't know, IPMI is a standard for system management, 
it provides ways to detect the managed devices in the system and sensors 
attached to them.  You can get more information at 
http://www.intel.com/design/servers/ipmi/spec.htm

