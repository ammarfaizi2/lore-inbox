Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbTHZPeB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTHZPeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:34:01 -0400
Received: from [203.185.132.124] ([203.185.132.124]:17072 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262749AbTHZPd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:33:59 -0400
Message-ID: <3F4B7D7B.50401@nectec.or.th>
Date: Tue, 26 Aug 2003 22:32:11 +0700
From: Samphan Raruenrom <samphan@nectec.or.th>
Organization: NECTEC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en, th
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Jens Axboe <axboe@suse.de>, Jens Axboe <axboe@image.dk>,
       linux-kernel@vger.kernel.org, Linux TLE Team <rdi1@opentle.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [Rdi1] Re: [PATCH] Add MOUNT_STATUS ioctl to cdrom device
References: <3F4A53ED.60801@nectec.or.th> <20030825195026.A10305@infradead.org> <3F4B0343.7050605@nectec.or.th> <20030826083249.B20776@infradead.org> <3F4B23E2.8040401@nectec.or.th> <20030826105613.A23356@infradead.org> <20030826095830.GA20693@suse.de> <3F4B44C2.4030406@nectec.or.th> <20030826145821.A26398@infradead.org>
In-Reply-To: <20030826145821.A26398@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
 > On Tue, Aug 26, 2003 at 06:30:10PM +0700, Samphan Raruenrom wrote:
 >>>>This doesn't make sense at all.  Just try the unmount and
 >>>>tell the user if it failed - you can't say whether it will
 >>>>fail before trying.
 >>Yes, you can! Reading the code, if vfsmount.mnt_count > 1 then
 >>umount on that device will fail.
 > if you are doing the unmount currently and nothing changes because
 > you hold the nessecary locks, yes.  But as soon as you drop the locks
 > this is void.  There's no way to find out whether you can unmount
 > a filesystem except trying it.

_^_ I understand it now. Thank you for your patience in explaining this
to me. I learn quite a lot of things in <4 hours! Thank you everyone.
I'll try to make a good use of what I learn here, e.g. to write another
GNOME automounter that use the new "event status notification" and also
let users eject their CDs -
"without polling" - possible?
It must be real cool to write such daemon (polling make any hacker feel guilty).

-- 
Samphan Raruenrom,
The Open Source Project,
National Electronics and Computer Technology Center,
National Science and Technology Development Agency,
Thailand.

