Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbTHTNXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 09:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbTHTNXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 09:23:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:26598 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261946AbTHTNXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 09:23:23 -0400
Message-ID: <3F437646.4050107@gamic.com>
Date: Wed, 20 Aug 2003 15:23:18 +0200
From: Sergey Spiridonov <spiridonov@gamic.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: how to turn off, or to clear read cache?
References: <200308201322.h7KDMQga000797@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200308201322.h7KDMQga000797@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
>>I need to make some performance tests. I need to switch off or to clear 
>>read cache, so that consequent reading of the same file will take the 
>>same amount of time.
>>
>>Is there an easy way to do it, without rebuilding the kernel?
> 
> 
> Unmount and remount the filesystem.


Would

# mount -o remount

do the job?

I'm not able to unmount and remount.

-- 
Best regards, Sergey Spiridonov

