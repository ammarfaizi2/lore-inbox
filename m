Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317125AbSEXMHI>; Fri, 24 May 2002 08:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317127AbSEXMHH>; Fri, 24 May 2002 08:07:07 -0400
Received: from [195.63.194.11] ([195.63.194.11]:40717 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317125AbSEXMHG> convert rfc822-to-8bit; Fri, 24 May 2002 08:07:06 -0400
Message-ID: <3CEE1DFE.4080500@evision-ventures.com>
Date: Fri, 24 May 2002 13:03:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Oleg Drokin <green@namesys.com>, "Gryaznova E." <grev@namesys.botik.ru>,
        martin@dalecki.de, Linux Kernel <linux-kernel@vger.kernel.org>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [reiserfs-dev] Re: IDE problem: linux-2.5.17
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFC5B.3030701@evision-ventures.com> <20020523193959.A2613@namesys.com> <3CED004A.6000109@evision-ventures.com> <20020524005057.F27005@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Vojtech Pavlik napisa³:

> 
>>Hmm thinking again about it... It occurrs to me
>>that actually there should be a mechanism which tells the
>>host chip drivers whatever there are only just one or
>>two drivers connected. I will have to look in to it.
> 
> 
> There is no such mechanism (except for probing the drives). IDE has
> quite nonsensical "split" termination - the termination resistors are
> always present even on the middle device. This is to "simplify" things
> ...
> 

Yes there is the host chip timer setting is basically
changing the termination properties on the hsot chips part
of the connection. This is the reason I was thinking
that making the driver for it know how many drivers
are attached to it could make some sense.

