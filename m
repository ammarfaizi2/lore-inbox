Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbRGXJcF>; Tue, 24 Jul 2001 05:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267199AbRGXJbz>; Tue, 24 Jul 2001 05:31:55 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:25302 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S267180AbRGXJbr>; Tue, 24 Jul 2001 05:31:47 -0400
Message-ID: <3B5D4024.2080109@AnteFacto.com>
Date: Tue, 24 Jul 2001 10:30:12 +0100
From: Padraig Brady <Padraig@AnteFacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org,
        linux-fsdev@vger.kernel.org
Subject: Re: Yet another linux filesytem: with version control
In-Reply-To: <20010723141751.W6820@work.bitmover.com> <200107240524.f6O5OwX286884@saturn.cs.uml.edu> <20010723223413.G15284@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Larry McVoy wrote:

> 
> Useful stuff would be the copy on write file system, that's good for SCM
> and other things

Ooh ooh! are there any filesystems @ present that support copy on write?
Seems like a very useful feature that would be relatively easy to 
implement (just
store a hash for each file in it's inode). With the ammount of duplicate 
files on my
system (see freshmeat.net/projects/fslint) it would be very useful. 
write() already
supports ENOSPC because of holes in files etc. There would be large 
overhead
though as the hash for a file would have to be generated on each write() 
? For a
"revision control" filesystem it would probably be more appropriate to 
work @ the
block level instead? Hmm snapFS be appropriate for this ?
http://uwsg.iu.edu/hypermail/linux/kernel/0103.0/0436.html
Sorry just thinking out load..

Padraig.

