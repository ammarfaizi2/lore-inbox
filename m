Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274520AbRIZLfc>; Wed, 26 Sep 2001 07:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274626AbRIZLfX>; Wed, 26 Sep 2001 07:35:23 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:56781 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S274520AbRIZLfD>; Wed, 26 Sep 2001 07:35:03 -0400
Message-ID: <3BB1BC51.4070102@antefacto.com>
Date: Wed, 26 Sep 2001 12:30:25 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Eli Carter <eli.carter@inet.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] core file naming option
In-Reply-To: <3BB104A9.3AD512A5@inet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Carter wrote:

>Alan et. all,
>
>The attached patch adds an option to the build to have core files named
>core.processname, but defaulting to the current behaviour of course. 
>For most people the single 'core' file is sufficient, but when the sky
>is falling, it's nice to have more places for it to land.  :)
>So, is this something that might go into the kernel, or are their
>philisophical reasons against it?  (The patch is against 2.2.19.  I
>haven't looked at 2.4.x yet.  Let me know if you want a 2.4 or if I
>should send it to Linus, or...)
>
>Questions, comments, etc. welcome,
>
Other Unix' have used core.pid as the name. Wouldn't this be better?
Especially when the process name is already stored in a core file
(`file core` will give you this). Hmm I wonder could we use this
core.pid format to dump the core for each thread (probably a bad idea).

Padraig.

