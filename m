Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312931AbSDOGD5>; Mon, 15 Apr 2002 02:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312997AbSDOGD4>; Mon, 15 Apr 2002 02:03:56 -0400
Received: from [195.63.194.11] ([195.63.194.11]:58631 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312931AbSDOGDz>; Mon, 15 Apr 2002 02:03:55 -0400
Message-ID: <3CBA5EBD.8060201@evision-ventures.com>
Date: Mon, 15 Apr 2002 07:01:49 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.5.8 does not boot
In-Reply-To: <UTC200204142229.WAA577107.aeb@cwi.nl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> Hm, I submitted two patches against 2.5.8pre3,
> but I see the real 2.5.8 has appeared already.
> That makes the first patch superfluous.
> The second one is still needed.
> 
> Booting 2.5.8 yields a crash at ide-disk.c:360
> 	BUG_ON(drive->tcq->active_tag != -1);
> 

I think that the TCQ changes simply don't harmonize with
setups where there is no host chip driver enabled. But that's
just a guess I will have to look in to it.

