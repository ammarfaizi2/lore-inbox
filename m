Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317795AbSGVSIr>; Mon, 22 Jul 2002 14:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317798AbSGVSIr>; Mon, 22 Jul 2002 14:08:47 -0400
Received: from [195.63.194.11] ([195.63.194.11]:10252 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317795AbSGVSIq>; Mon, 22 Jul 2002 14:08:46 -0400
Message-ID: <3D3C499E.90800@evision.ag>
Date: Mon, 22 Jul 2002 20:06:22 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Jeff Dike <jdike@karaya.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, jdike@ccure.karaya.com
Subject: Re: [PATCH] UML - part 1 of 2
References: <200207221715.MAA03040@ccure.karaya.com> <20020722183844.A8526@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, Jul 22, 2002 at 12:15:29PM -0500, Jeff Dike wrote:
> 
>>include/linux/linkage.h -
>>	UML needs FASTCALL defined as regparm(3), too.
> 
> 
> The fastcall definition should go into an asm/ header instead of such hacks..
> 
> the disk accounting stuff is also bogus - instead of wasting ram with
> huge array it should rather be dynamically-allocated in a per-disk
> structure..

... which the name of is: struct genpart.

