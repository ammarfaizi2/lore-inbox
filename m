Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbSJPWI7>; Wed, 16 Oct 2002 18:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSJPWI7>; Wed, 16 Oct 2002 18:08:59 -0400
Received: from tailtiu.davidcoulson.net ([194.159.156.4]:25011 "EHLO
	mail.mx.davidcoulson.net") by vger.kernel.org with ESMTP
	id <S261572AbSJPWI5>; Wed, 16 Oct 2002 18:08:57 -0400
Message-ID: <3DADE4DA.9080508@davidcoulson.net>
Date: Wed, 16 Oct 2002 23:14:50 +0100
From: David Coulson <david@davidcoulson.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020723
X-Accept-Language: en-gb
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: linux-kernel@vger.kernel.org,
       UML devel <user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: swap_dup/swap_free errors with 2.4.20-pre10
References: <Pine.LNX.4.44L.0210161922570.5583-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marcelo,

> Any news on this one, David?

Sorry, I forgot to follow up - I spend most of yesterday morning trying 
to stabalise the thing and didn't end up posting my results. Basically, 
my board can only handle 1.5Gb of PC133 properly, even though it will 
try to use 2Gb if you put that much in it. Interestingly enough, it 
passed the memtest86 tests I ran on it the other night, so I'm not sure 
what's going on there. Tyan, the board manufacturer, confirmed that the 
system is only stable with 1.5Gb of PC133, which is somewhat 
disappointing, but I guess I'll have to live. Interestingly, it ran fine 
for about 8hrs before going funny the first time, then it would spit out 
swap_dup/free errors within 30 to 60mins five times in a row.

I had weird lockups under 2.4.20-pre9, where the system would behave 
oddly - Most commands would work, but 'ps' simply locked up and I 
couldn't Ctrl-C out of it. I've moved back to 2.4.19-ck7-rmap, which 
seems to be stable at the moment, although I may take another look at 
the 2.4.20-pre10 kernel sometime. As always, I didn't have a keyboard or 
monitor hooked up to it, so I couldn't do too much with sysrq, but I'll 
be ready if it does it again.

Any points about the above lock-ups would be useful - Since 'ps' locks 
and others don't (e.g. 'ls'), I think it's quite a specific issue, 
although I've so far been unable to track it down.

Thanks,
David

-- 
David Coulson                                  http://davidcoulson.net/
d@vidcoulson.com                       http://journal.davidcoulson.net/

