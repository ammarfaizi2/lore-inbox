Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263689AbTHZNe7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 09:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263710AbTHZNe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 09:34:58 -0400
Received: from [203.185.132.124] ([203.185.132.124]:13472 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263689AbTHZNe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 09:34:57 -0400
Message-ID: <3F4B561A.2000103@nectec.or.th>
Date: Tue, 26 Aug 2003 19:44:10 +0700
From: Samphan Raruenrom <samphan@nectec.or.th>
Organization: NECTEC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en, th
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Linux TLE Team <rdi1@opentle.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [Rdi1] Re: [PATCH] Add MOUNT_STATUS ioctl to cdrom device
References: <3F4A53ED.60801@nectec.or.th> <20030825195026.A10305@infradead.org> <3F4B0343.7050605@nectec.or.th> <20030826083249.B20776@infradead.org> <3F4B23E2.8040401@nectec.or.th> <20030826105613.A23356@infradead.org> <20030826095830.GA20693@suse.de> <3F4B44C2.4030406@nectec.or.th> <20030826113633.GA22124@suse.de>
In-Reply-To: <20030826113633.GA22124@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Aug 26 2003, Samphan Raruenrom wrote:
>>>Exactly. You poll media events from the drive, and upon an eject request
>>>you try and umount it. If it suceeds, you eject the tray. 
>>No, it seems impossible to sense the eject request (right?). This
> No it isn't, in fact there are several ways to do it. Just by searching
> this list you should be able to find them.

YES!! http://www.ussg.iu.edu/hypermail/linux/kernel/0202.0/att-0603/01-cd_poll.c
get_media_event() = 1 -> eject
Thanks :-)  I think you can't imagine how happy I am now. Thank you again.

>>is what I really did with the patched kernel and patched magicdev.
> magicdev is a piece of crap.

Why? I read all its code. Because of 2 sec. polling?

> I think you need to spend a little more time thinking/researching this
> problem. At least it really looks like you are going about it all wrong.

You've just put me on the right track. Thank you very much. I really
appreciate your and every others insightful comments.

