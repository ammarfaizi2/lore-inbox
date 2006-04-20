Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWDTSmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWDTSmH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 14:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWDTSmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 14:42:07 -0400
Received: from zcars04f.nortel.com ([47.129.242.57]:38562 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP
	id S1751212AbWDTSmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 14:42:06 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
	<20060419200001.fe2385f4.diegocg@gmail.com>
	<Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
	<20060420145041.GE4717@suse.de>
From: "Linh Dang" <linhd@nortel.com>
Organization: Null
Date: Thu, 20 Apr 2006 14:40:08 -0400
In-Reply-To: <20060420145041.GE4717@suse.de> (Jens Axboe's message of "Thu,
 20 Apr 2006 16:50:42 +0200")
Message-ID: <wn5fyk85bw7.fsf@linhd-2.ca.nortel.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:

> On Wed, Apr 19 2006, Linus Torvalds wrote:
>> There are some other buffer management system calls that I haven't
>> done yet (and when I say "I haven't done yet", I obviously mean
>> "that I hope some other sucker will do for me, since I'm lazy"),
>> but that are obvious future extensions:
>
> Well it's worked so far, hasn't it? :-)
>
>> - an ioctl/fcntl to set the maximum size of the buffer. Right now
>>   it's
>> hardcoded to 16 "buffer entries" (which in turn are normally limited to 
>> one page each, although there's nothing that _requires_ that a buffer 
>> entry always be a page).
>
> This is on a TODO, but not very high up since I've yet to see a case
> where the current 16 page limitation is an issue. I'm sure something
> will come up eventually, but until then I'd rather not bother.

DVD burning! splicing those huge VOB files into the dvd device would
be nice. And believe me, the current 16 entries of the pipe is nowhere
enough to sustain burning at 8X avg speed or higher.

It's a special case but it'd benefit a LOT of ppl ;-)

-- 
Linh Dang
