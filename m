Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTFSXcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbTFSXbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:31:00 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:63473 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261928AbTFSX22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:28:28 -0400
Message-ID: <3EF24A70.4010608@mvista.com>
Date: Thu, 19 Jun 2003 16:42:40 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
References: <3EE8D038.7090600@mvista.com> <bcd3rj$1it$1@old-penguin.transmeta.com> <20030619203230.E6248@almesberger.net>
In-Reply-To: <20030619203230.E6248@almesberger.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Werner Almesberger wrote:

>Linus Torvalds wrote:
>  
>
>>[ Event demons ] encourage doing everything in one program,
>>keeping state in private memory, depending on ordering, and just
>>generally do bad things. 
>>    
>>
>
>Well, the ordering bit is the hairy part. As long as it doesn't
>matter if an event gets lost every once in a while, and in which
>order they get processed, things are fine as they are.
>
>But then it scares me to see people start to try to design some
>general serialization mechanism on top of /sbin/hotplug
>  
>
A serialization methodology can be built on /sbin/hotplug, but it has 
all of the problems that Linus previously talked about for a kernel 
event queue.  The difference is that the problem is moved to userland.

>- Werner
>  
>

-steve



