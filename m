Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbTJMHNl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 03:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbTJMHNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 03:13:41 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:44496 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261507AbTJMHNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 03:13:37 -0400
Message-ID: <3F8A50A0.8030809@namesys.com>
Date: Mon, 13 Oct 2003 11:13:36 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Mark Williams (MWP)" <mwp@internode.on.net>
CC: Tomas Szepe <szepe@pinerecords.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS causing kernel panic?
References: <20031012121331.GA665@linux.comp> <yw1xhe2eiqru.fsf@zaphod.guide> <20031012140048.GA554@linux.comp> <20031012143245.GA21010@louise.pinerecords.com> <20031012162434.GB725@linux.comp>
In-Reply-To: <20031012162434.GB725@linux.comp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Williams (MWP) wrote:

>>On Oct-12 2003, Sun, 23:30 +0930
>>Mark Williams (MWP) <mwp@internode.on.net> wrote:
>>
>>    
>>
>>>>"Mark Williams (MWP)" <mwp@internode.on.net> writes:
>>>>
>>>>        
>>>>
>>>>>I am having rather ugly problems with this card using the PDC20269 chip.
>>>>>Almost as soon as either of the HDDs on the controller are used, the
>>>>>kernel hangs solid with a dump of debugging info.
>>>>>          
>>>>>
>>>>That dump could be useful.  Also full output of dmesg and "lspci -vv"
>>>>can be helpful.
>>>>        
>>>>
>>>Ok, seems this is not a controller fault, but really a problem with
>>>ReiserFS (!!).
>>>      
>>>
>>Do you really expect reiserfs code (or any other fs code for that matter)
>>not to choke on a corrupted filesystem?
>>
>>Put the disk on a trusted controller and fsck.
>>    
>>
>
>No, i wouldnt expect reiserfs to handle the data on the FS, but i also
>wouldnt have expected it to cause a kernel panic and hang the system.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
I'll be happy to accept a patch changing it to remount the fs ro instead 
of panicking.

-- 
Hans


