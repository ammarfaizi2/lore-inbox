Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135992AbRD0Jk1>; Fri, 27 Apr 2001 05:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135994AbRD0JkR>; Fri, 27 Apr 2001 05:40:17 -0400
Received: from t2.redhat.com ([199.183.24.243]:61688 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135992AbRD0JkF>; Fri, 27 Apr 2001 05:40:05 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se> 
In-Reply-To: <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se> 
To: Bjorn Wesen <bjorn@sparta.lu.se>
Cc: Padraig Brady <padraig@antefacto.com>, linux-kernel@vger.kernel.org
Subject: Re: ramdisk/tmpfs/ramfs/memfs ? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 27 Apr 2001 10:36:18 +0100
Message-ID: <21093.988364178@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bjorn@sparta.lu.se said:
>  you could try using jffs2 on a RAM-simulated MTD partition. i think
> that would work but i have not tried it..

It works. Most of the early testing and development was done on it. It 
wouldn't give you dynamic sizing like ramfs though. 

It would be nice to have a version of ramfs which compresses pages into a 
separate backing store when they're unused. Shame somebody nicked the name 
'cramfs' for something else, really :)

But I'm confused. Padraig, if you have no backing store, where do the 
initial contents of your root filesystem come from?

--
dwmw2


