Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272257AbTG3W5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272320AbTG3W4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:56:20 -0400
Received: from dm7-80.slc.aros.net ([66.219.221.80]:55212 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S272318AbTG3Wzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:55:38 -0400
Message-ID: <3F284CE6.6080701@aros.net>
Date: Wed, 30 Jul 2003 16:55:34 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2+ext3+dbench=Buffer I/O error
References: <5.2.1.1.2.20030730163933.00b41b50@wen-online.de> <20030730150902.5281f72c.akpm@osdl.org>
In-Reply-To: <20030730150902.5281f72c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Mike Galbraith <efault@gmx.de> wrote:
>  
>
>>Greetings,
>>
>>While trying to duplicate Randy Hron's "dbench has intermittent hang on 
>>2.6.0-test1-ac2" report, I received quite a few "Buffer I/O error on 
>>/dev/hda8, logical block N" messages.  (changing elevators makes no 
>>difference fwiw).
>>    
>>
>
>That's just a gremlinlet.  You can delete the offending printk for now.
>
>  
>
>>I went back to test1, and it spat up a couple of "buffer 
>>layer error" messages and associated traces.   Attempting to umount 
>>afterward to run fsck left umount in D state.  See attachment.
>>    
>>
>
>Well that's a worry.  Is it repeatable? . . .
>
Any chance this problem is a consequence of not yet having Sean 
Estabrooks partial bvec patch in this person's kernel??? 
<http://www.ussg.iu.edu/hypermail/linux/kernel/0307.3/0861.html>. Jens 
said he applied it on 2003/7/27 so it doesn't seem like this could have 
made it into 2.6.0-test1-ac2.

