Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWBJEbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWBJEbV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 23:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWBJEbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 23:31:21 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:23966 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751071AbWBJEbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 23:31:20 -0500
Message-ID: <43EC170C.6090807@vilain.net>
Date: Fri, 10 Feb 2006 17:31:08 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>,
       Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: swsusp done by migration (was Re: [RFC][PATCH 1/5] Virtualization/containers:
 startup)
References: <43E38BD1.4070707@openvz.org> <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru> <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <m1lkwoubiw.fsf@ebiederm.dsl.xmission.com> <43E71018.8010104@sw.ru> <m1hd7condi.fsf@ebiederm.dsl.xmission.com> <1139243874.6189.71.camel@localhost.localdomain> <m13biwnxkc.fsf@ebiederm.dsl.xmission.com> <20060208215412.GD2353@ucw.cz> <m1mzh02y3m.fsf@ebiederm.dsl.xmission.com> <7CCC1159-BF55-4961-BC24-A759F893D43F@mac.com>
In-Reply-To: <7CCC1159-BF55-4961-BC24-A759F893D43F@mac.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> <wishful thinking>
> I can see another extension to this functionality.  With appropriate  
> changes it might also be possible to have a container exist across  
> multiple computers using some cluster code for synchronization and  
> fencing.  The outermost container would be the system boot container,  
> and multiple inner containers would use some sort of network- 
> container-aware cluster filesystem to spread multiple vservers across  
> multiple servers, distributing CPU and network load appropriately.
> </wishful thinking>

Yeah.  If you fudged/virtualised /dev/random, the system clock, etc you
could even have Tandem-style transparent High Availability.
</more wishful thinking>

Actually there is relatively little difference between a NUMA system and
a cluster...

Sam.
