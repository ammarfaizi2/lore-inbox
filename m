Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVACWqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVACWqZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVACWmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:42:45 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:31129 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261929AbVACWja
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:39:30 -0500
Message-ID: <41D9C9B2.2070006@tmr.com>
Date: Mon, 03 Jan 2005 17:39:46 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Jens Axboe <axboe@suse.de>
CC: Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
References: <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com><Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com> <20050103192844.GA29678@suse.de>
In-Reply-To: <20050103192844.GA29678@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Jan 03 2005, Bill Davidsen wrote:
> 
>>SCSI command filtering - while I totally support the idea (and always
>>have), I miss running cdrecord as a normal user. Multisession doesn't work
>>as a normal user (at least if you follow the man page) because only root
>>can use -msinfo. There's also some raw mode which got a permission denied,
>>don't remember as I was trying something not doing production stuff.
> 
> 
> So look at dmesg, the kernel will dump the failed command. Send the
> result here and we can add that command, done deal. 2.6.10 will do this
> by default.
> 

Is this enough? I'm building 2.6.10-bk6 on a spare machine to try this 
on a system with a "scsi" CD interface via USB. The commands appear to 
go through the same process, but I'll know in an hour or so.

I was going to look these up before suggesting that they were 
trustworthy, but I'll take this as a offer to do that and accept! 
Obviously security comes first, if these are not trustworthy I won't 
argue for their inclusion.

kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
scsi: unknown opcode 0x01
scsi: unknown opcode 0x55
scsi: unknown opcode 0x1e
scsi: unknown opcode 0x35

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
