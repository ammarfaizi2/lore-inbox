Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319149AbSIJOua>; Tue, 10 Sep 2002 10:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319150AbSIJOua>; Tue, 10 Sep 2002 10:50:30 -0400
Received: from mta.sara.nl ([145.100.16.144]:50393 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S319149AbSIJOu3>;
	Tue, 10 Sep 2002 10:50:29 -0400
Date: Tue, 10 Sep 2002 16:55:10 +0200
Subject: Re: writing OOPS/panic info to nvram?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linux-kernel@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
From: Remco Post <r.post@sara.nl>
In-Reply-To: <20020906100650.D35@toy.ucw.cz>
Message-Id: <4DE1BD2E-C4CD-11D6-9C2C-000393911DE2@sara.nl>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On vrijdag, september 6, 2002, at 12:06 , Pavel Machek wrote:

> Hi!
>
>> driver oopses... Maybe do something like:
>>
>> if there is enough space on disk && ..., use that else
>> if there is a swap over nfs && ..., use that else
>> if there is a tape drive attaced and a tape is present and it is
>> writeable... else
>> if there is nvram available use that
>
> You just killed any data you had on the tape... too bad.
> 								Pavel

Yes, so, or you just saved that oops that has been bugging you for 
months... (And yes I'm probably one of those rare people that has 
tapedrives attached that are not used for anything usefull).

---
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167
PGP keys at http://home.sara.nl/~remco/keys.asc

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer 
industry
didn't even foresee that the century was going to end." -- Douglas Adams


