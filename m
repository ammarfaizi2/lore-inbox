Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbTJEQJV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 12:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263148AbTJEQJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 12:09:21 -0400
Received: from mail.g-housing.de ([62.75.136.201]:14467 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263144AbTJEQJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 12:09:20 -0400
Message-ID: <3F804234.9070606@g-house.de>
Date: Sun, 05 Oct 2003 18:09:24 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: de-de, de, en-gb, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs one user DoS?
References: <20031004120625.GA41175@colocall.net> <3F7EF082.3020702@namesys.com>
In-Reply-To: <3F7EF082.3020702@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser schrieb:
> Max A. Krasilnikov wrote:
> 
>> Hi!
>> I have found such strange thing:
>>
>> pseudo@avalon at 14:04:00  ~> dd if=/dev/zero of=file bs=1 count=0 
>> seek=1000000000000
>>
>> After that my Intel Celeron 800 MHz/384M RAM 60G/Seagate U6 under
>> Linux-2.4.22-grsec on reiserfs was utilized 100% for more than 2 hours.
>> dd process can't be killed.
>>
>> Is this my flow or real bug?
>>
>>  
>>
> it is fixed in reiser4.  linux has a lot of DOS vulerabilities to logged 
> in users, mostly due to the ability to consume all of some resource or 
> another.  forgive me for not discussing them publicly.;-)

perhaps "ulimit" could help here.

man bash-builtins, search for "ulimit" then.

Christian.
-- 
BOFH excuse #153:

Big to little endian conversion error

