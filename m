Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265851AbSL3Uc3>; Mon, 30 Dec 2002 15:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265995AbSL3Uc0>; Mon, 30 Dec 2002 15:32:26 -0500
Received: from pD9E460C6.dip.t-dialin.net ([217.228.96.198]:25820 "EHLO xpc823")
	by vger.kernel.org with ESMTP id <S265851AbSL3UcW>;
	Mon, 30 Dec 2002 15:32:22 -0500
Message-ID: <3E10AFE7.6030301@elitedvb.net>
Date: Mon, 30 Dec 2002 21:43:19 +0100
From: Felix Domke <tmbinc@elitedvb.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Indention - why spaces?
References: <20021230122857.GG10971@wiggy.net> <200212301249.gBUCnXrV001099@darkstar.example.net> <20021230131725.GA16072@suse.de> <32797.62.98.199.18.1041274402.squirrel@webmail.roma2.infn.it> <20021230190034.GG3143@conectiva.com.br> <3E109EF1.5040901@WirelessNetworksInc.com>
In-Reply-To: <3E109EF1.5040901@WirelessNetworksInc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

> This problem is as old as the typewriter itself.  The trouble is that 
> a Tab character doesn't have a fixed size - some set it to 3 
> characters wide, some to 4 some to 8, or whatever.
>
> The 'indent' program was written a couple of decades ago, to pretty 
> print C code.  It has a 'GNU' standard, but I'm not aware of a 'Linux' 
> standard.  Anyhoo, the only way to prevent indentation wars is to use 
> spaces, not tabs and to set 'diff' to ignore white space when 
> comparing files... 

Anyhow, sorry, i really can't understand that. What could be more 
"indention war preventing" that letting everybody use his own indention 
width?

There are two main aspects of *not* using tabs:
 - editors mess them up. but: use an *editor*. not a word processor. 
kernel source's line endings are \n, not \r\n. some (windows) editors 
mess them up.  and nobody cares (and that's ok that way. nobody WANTS to 
use an editor which messes up so simple things).
some editors don't show tabs. well. this leads to a mixup of tabs <-> 
spaces. but if you really fear about this, just use an editor which 
supports showing tabs. joe doesn't show spaces (by default?), but i 
never missed that, for example.
 - aligning. well, just use spaces for aligning, tabs for indention. two 
different things. two different characters.

TAB characters simply *have* no assigned width. that's the reason for 
them. they are not a macro for 3/4/8 spaces.

not using spaces, in my eyes, just *takes* a possibility to 
platform-independant format sourcecode on the given screensize. it gives 
you nothing.

and as they might be some pitfalls (wrong aligning etc.), you can still 
set the tabwidth to the one of the author. in that case, you didn't win 
anything by using tabs, but you didn't loose either.

again, i was just *wondering* why everybody is using spaces, and still, 
i can't find a good reason for that. if anybody shows me that, i'll 
maybe start using spaces (again).

felix



