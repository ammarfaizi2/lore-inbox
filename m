Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316892AbSFQKkg>; Mon, 17 Jun 2002 06:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316895AbSFQKkg>; Mon, 17 Jun 2002 06:40:36 -0400
Received: from [195.63.194.11] ([195.63.194.11]:32786 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316892AbSFQKkf> convert rfc822-to-8bit; Mon, 17 Jun 2002 06:40:35 -0400
Message-ID: <3D0DBC9F.1090604@evision-ventures.com>
Date: Mon, 17 Jun 2002 12:40:31 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] ide locking botch
References: <20020617101501.GA811@suse.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Jens Axboe napisa³:
> Hi Martin et al,
> 
> I took a quick look at why 2.5.21 hung at boot detecting partitions,
> because a 2.5.22 did the exact same thing on my test box today... The
> tcq locking is completely screwed now, and as I said before the weekend
> I think the entire locking is just getting worse now.

Whatever...

> Anyways, this patch at least attempts to make tcq follow the channel
> lock usage to make it work for me.

That explains it. Indeed I have a system with a TCQ using disk,
but I just don't boot from it. Anyway thanks for looking after it.



