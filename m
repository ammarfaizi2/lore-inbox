Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTJLUmZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 16:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263531AbTJLUmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 16:42:25 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:50631 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263527AbTJLUmY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 16:42:24 -0400
Message-ID: <3F89BCAE.8090404@namesys.com>
Date: Mon, 13 Oct 2003 00:42:22 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Mark Williams (MWP)" <mwp@internode.on.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS causing kernel panic?
References: <20031012121331.GA665@linux.comp> <yw1xhe2eiqru.fsf@zaphod.guide> <20031012140048.GA554@linux.comp>
In-Reply-To: <20031012140048.GA554@linux.comp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Williams (MWP) wrote:

>>"Mark Williams (MWP)" <mwp@internode.on.net> writes:
>>
>>    
>>
>>>I am having rather ugly problems with this card using the PDC20269 chip.
>>>Almost as soon as either of the HDDs on the controller are used, the
>>>kernel hangs solid with a dump of debugging info.
>>>      
>>>
>>That dump could be useful.  Also full output of dmesg and "lspci -vv"
>>can be helpful.
>>    
>>
>
>Ok, seems this is not a controller fault, but really a problem with
>ReiserFS (!!).
>
>It seems one of the HDDs on the controller i thought had a problem is
>corrupted, and the corrupted ReiserFS on it is causing the kernel to
>panic.
>  
>
reiserfs is not warranted to work on corrupted hdds.....

-- 
Hans


