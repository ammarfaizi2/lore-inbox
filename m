Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbVLUUDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVLUUDo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 15:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVLUUDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 15:03:44 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:15335 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S964807AbVLUUDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 15:03:43 -0500
Message-ID: <43A9B513.6040706@mnsu.edu>
Date: Wed, 21 Dec 2005 14:03:31 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sander@humilis.net
CC: Arjan van de Ven <arjan@infradead.org>,
       David Lang <dlang@digitalinsight.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <200512201428.jBKESAJ5004673@laptop11.inf.utfsm.cl> <Pine.LNX.4.62.0512200951080.11093@qynat.qvtvafvgr.pbz> <1135102197.2952.23.camel@laptopd505.fenrus.org> <20051221111220.GA28577@favonius>
In-Reply-To: <20051221111220.GA28577@favonius>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander wrote:

>Arjan van de Ven wrote (ao):
>  
>
>>>how many other corner cases are there that these distros just choose
>>>not to support, but need to be supported and tested for the vanilla
>>>kernel?
>>>      
>>>
>>as someone who was at that distro in the time.. none other than XFS
>>and reiserfs4.
>>    
>>
>
>FWIW, I have a few servers and my workstation running Reiser4 and
>CONFIG_4KSTACKS=y for several months now, and haven't encountered
>problems yet. One server also runs Reiser4 on top op lvm2, and another
>Reiser4 on top of sw raid1.
>
>I know -mm + Reiser4 + 4kstacks is bleeding edge in more than one way,
>but I like that for my workstations and the servers are
>test/non-critical.
>
>All systems do have real-life load though. I'd be happy to provide data
>from these systems. Just mail me the commands.
>
>  
>

I would like to add to this.  I've been using XFS+LVM+SCSI in a 14,000+ 
user University email server with 4k stacks since it became available.  
I didn't even have problems BEFORE the XFS stuff was stack-dieted.  I 
would also be happy to provide more data.

-- 
Jeffrey Hundstad

