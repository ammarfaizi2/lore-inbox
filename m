Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316723AbSGVK6n>; Mon, 22 Jul 2002 06:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316728AbSGVK6k>; Mon, 22 Jul 2002 06:58:40 -0400
Received: from [195.63.194.11] ([195.63.194.11]:32776 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316723AbSGVK6f>; Mon, 22 Jul 2002 06:58:35 -0400
Message-ID: <3D3BE4C7.2060203@evision.ag>
Date: Mon, 22 Jul 2002 12:56:07 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: martin@dalecki.de, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 sysctl
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com> <3D3BE17F.3040905@evision.ag> <20020722125347.B16685@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, Jul 22, 2002 at 12:42:07PM +0200, Marcin Dalecki wrote:
> 
>>This is making the sysctl code acutally be written in C.
>>It wasn't mostly due to georgeous ommitted size array "forward
>>declarations". As a side effect it makes the table structure easier to
>>deduce.
> 
> 
> Please don't remove the trailing commas in the enums.  they make adding
> to them much easier and are allowed by gcc (and maybe C99, I'm not
> sure).

It's an GNU-ism. If you have any problem with "adding vales", just
invent some dummy end-value. I have a problem with using -pedantic.

