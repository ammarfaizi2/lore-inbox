Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267402AbTHJN3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 09:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267471AbTHJN3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 09:29:24 -0400
Received: from adsl-63-194-232-126.dsl.lsan03.pacbell.net ([63.194.232.126]:31238
	"HELO alpha.dyndns.org") by vger.kernel.org with SMTP
	id S267402AbTHJN3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 09:29:23 -0400
Message-ID: <3F3648AD.1030201@alpha.dyndns.org>
Date: Sun, 10 Aug 2003 06:29:17 -0700
From: Mark McClelland <mark@alpha.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030707
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Stefan B <ChromosML@web.de>, linux@1g6.biz,
       Gerd Knorr <kraxel@bytesex.org>
Subject: Re: ov511 2.6.0-test3
References: <200308092115.18501.linux@1g6.biz> <3F356BC6.9020904@web.de> <3F35D538.1040205@web.de>
In-Reply-To: <3F35D538.1040205@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan B wrote:

> Stefan B. wrote:
>
>> Try adding this to driver/media/video/videodev.c:
>> (e.g. after the other EXPORT_SYMBOL lines)
>>
>> void *video_proc_entry;
>> EXPORT_SYMBOL(video_proc_entry);
>
> sorry, not good; this patch should do


Unless you need the /proc support for something, an easier solution is 
just to disable CONFIG_VIDEO_PROC_FS.

Gerd, did you leave that config option in on purpose (so that the broken 
drivers would get noticed)?

Ps.: The ov511 sysfs conversion patch should be finished this evening. 
It will be sent to Linux-USB-Devel.

-- 
Mark McClelland
mark@alpha.dyndns.org


