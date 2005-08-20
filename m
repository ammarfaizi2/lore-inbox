Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbVHTASu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbVHTASu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 20:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbVHTASu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 20:18:50 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:34699 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S965207AbVHTASu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 20:18:50 -0400
Message-ID: <430676E8.3070103@lifl.fr>
Date: Sat, 20 Aug 2005 02:18:48 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
Organization: LIFL
User-Agent: Mozilla Thunderbird 1.0.6-3mdk (X11/20050322)
X-Accept-Language: en, fr, ja, es
MIME-Version: 1.0
To: Imanpreet Arora <imanpreet@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux under 8MB
References: <c26b9592050818151154ff1a89@mail.gmail.com>
In-Reply-To: <c26b9592050818151154ff1a89@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

19.08.2005 00:11, Imanpreet Arora wrote/a écrit:
> Hi all,
> 
>               For the last couple of days, I have been trying to set
> up linux kernel under 8MB. So far I have set up a linux 2.4.31, which
> just works under 8MB. However, I would be grateful if someone could
> help with the following queries
> 
> a)          Is linux2.4 just the right option? What about linux 2.0.x?
> Or for that matter even <2.0
> b)          What are the specific issues that are to be considered
> while compiling an old kernel on a newer setup? I ask this because I
> compiled my current setup on a 2.6.11 machine and while doing "make
> modules_install", I got errors from depmod[%], complaining about
> depmod.old.  I had to kludge my way through by setting up a link from
> depmod.old to depmod.
> 

Last year, at the Realtime linux workshop, there was a paper about 
running Linux on a machine with 2Mb of RAM + 2Mb of Flash. They even 
manage to boot in 1 second! Nevertheless, they had to do several 
modifications to achieve this. Maybe with the new options in the 2.6 
kernel, it would be easier...

Check it here:
http://www.realtimelinuxfoundation.org/events/rtlws-2004/papers.html#PAPER_5795


Regards,
Eric
