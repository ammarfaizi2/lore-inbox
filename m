Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTDIHN5 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 03:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTDIHN4 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 03:13:56 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:15747 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP id S262882AbTDIHNz (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 03:13:55 -0400
Message-ID: <3E93CAC8.8070407@namesys.com>
Date: Wed, 09 Apr 2003 11:24:56 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.67 - reiserfs go boom.
References: <20030409011802.GD25834@suse.de> <20030409105339.A26788@namesys.com>
In-Reply-To: <20030409105339.A26788@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:

>Hello!
>
>On Wed, Apr 09, 2003 at 02:18:02AM +0100, Dave Jones wrote:
>
>  
>
>>Whilst running fsx.. (Though fsx didn't trigger any error,
>>and is still running)..
>>buffer layer error at fs/buffer.c:127
>>Call Trace:
>> [<c016d260>] __wait_on_buffer+0xd0/0xe0
>> [<c0121760>] autoremove_wake_function+0x0/0x50
>> [<c0121760>] autoremove_wake_function+0x0/0x50
>> [<c02886c8>] reiserfs_unmap_buffer+0x68/0xa0
>>    
>>
>
>Andrew Morton said "That's not a bug.  It is errant debugging code." because the page is locked by us,
>so buffers are safe.
>So I am not looking into this and hoping that somebody will fix the debugging code instead ;)
>
>Bye,
>    Oleg
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
Oleg, if someone doesn't do it for you in 7 days, you must do it....

errant debugging code is a bug....  when users (reasonably) think our fs 
has bugs, that needs to be fixed;-)

-- 
Hans


