Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSEVOQv>; Wed, 22 May 2002 10:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314465AbSEVOQu>; Wed, 22 May 2002 10:16:50 -0400
Received: from wotug.org ([194.106.52.201]:46141 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S314077AbSEVOQs>;
	Wed, 22 May 2002 10:16:48 -0400
Date: Wed, 22 May 2002 15:13:05 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, <linux-kernel@vger.kernel.org>,
        <acme@conectiva.com.br>
Subject: Re: AUDIT: copy_from_user is a deathtrap.
In-Reply-To: <200205221356.g4MDuCY03131@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0205221507080.3659-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2002, Denis Vlasenko wrote:
>Which name is 'good'/too short/too long is up to "big boys" to decide.
>I presume they know better, I don't hack on kernel day and night. They do.

Actually, in this case I would say it's the occasional hacker who is more 
likely to need good names, and consequently better placed to suggest them; the 
big boys presumably know this stuff so well it is a non-issue to them.

That said, I agree with Linus that copy_from_user et al is better than copyin, 
for reasons expressed earlier.

My work as a technical writer often results in comments like "I didn't 
understand that" or "no, it's not like that", when in fact the words are 
correct. I still take such reports seriously, though, as the point of writing
English is to convey meaning from you to someone's head, not to the paper.

All I can suggest about naming function calls is that consistency is generally 
better than point solutions.

Ruth

P.S. Might it be possible to avoid misuse of copy_ return values by changing 
the return type in some way?


-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

