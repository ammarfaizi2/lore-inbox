Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264141AbUAMMrV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 07:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264241AbUAMMrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 07:47:21 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:63783 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S264141AbUAMMrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 07:47:20 -0500
Message-ID: <4003E8BE.3000402@samwel.tk>
Date: Tue, 13 Jan 2004 13:46:54 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Jan De Luyck <lkml@kcore.org>, Kiko Piris <kernel@pirispons.net>,
       linux-kernel@vger.kernel.org, Dax Kelson <dax@gurulabs.com>,
       Bartek Kania <mrbk@gnarf.org>, Simon Mackinlay <smackinlay@mail.com>
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
References: <3FFFD61C.7070706@samwel.tk> <200401121409.44187.lkml@kcore.org> <20040112140238.GG24638@suse.de> <200401131200.16025.lkml@kcore.org> <20040113110110.GA6711@suse.de>
In-Reply-To: <20040113110110.GA6711@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>>>bo is accounted when io is actually put on the pending queue for the
>>>disk, so they really do go hand in hand. So you should use block_dump to
>>>find out why.
>>
>>It's nearly always reiserfs that causes the disk to spin up. Also, I'm
>>seeting the harddisk led light up every 5-7 seconds :-( weird.
> 
> Does 2.6 laptop mode patch even include the necessary reiser changes to
> make this work properly?

The reiserfs patch for "commit=" was included in Linux 2.6.1. I really 
don't know if it works with laptop mode, haven't tested it -- I don't 
use reiserfs. So, let's ask the world: is there anyone out there who is 
running laptop mode *successfully* with reiserfs?

-- Bart
