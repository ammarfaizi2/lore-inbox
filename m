Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275417AbTHIWLN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 18:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275421AbTHIWLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 18:11:13 -0400
Received: from adsl-63-194-232-126.dsl.lsan03.pacbell.net ([63.194.232.126]:62980
	"HELO alpha.dyndns.org") by vger.kernel.org with SMTP
	id S275417AbTHIWLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 18:11:12 -0400
Message-ID: <3F35717C.3040606@alpha.dyndns.org>
Date: Sat, 09 Aug 2003 15:11:08 -0700
From: Mark McClelland <mark@alpha.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030707
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Nicolas P." <linux@1g6.biz>
CC: linux-kernel@vger.kernel.org
Subject: Re: ov511 2.6.0-test3
References: <200308092115.18501.linux@1g6.biz>
In-Reply-To: <200308092115.18501.linux@1g6.biz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas P. wrote:

>It is new to kernel 2.6.0-test3 :
>
>*** Warning: "video_proc_entry" [drivers/usb/media/ov511.ko] undefined!
>  
>

That's due to the removal of /proc/video and its replacement with sysfs. 
I'll submit a patch for that later today.

>And documentation seems obsolete :
>
>This driver uses the Video For Linux API. You must say Y or M to
>"Video For Linux" (under Character Devices) to use this driver.
>Information on this API and pointers to "v4l" programs may be found
>on the WWW at <http://roadrunner.swansea.uk.linux.org/v4l.shtml>.
>
>
>Not any more under Character Devices, isn't it ?
>

Thanks for noticing that. I'll fix that too.

-- 
Mark McClelland
mark@alpha.dyndns.org


