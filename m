Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262938AbVDHTpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbVDHTpo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 15:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVDHTpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 15:45:44 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:61686 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262940AbVDHTot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 15:44:49 -0400
Message-ID: <4256DF27.5060607@tiscali.de>
Date: Fri, 08 Apr 2005 21:44:39 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050406)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrea Arcangeli <andrea@suse.de>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org> <4256BE7D.5040308@tiscali.de> <Pine.LNX.4.58.0504081047200.28951@ppc970.osdl.org> <4256D87C.5090207@tiscali.de> <Pine.LNX.4.58.0504081231130.28951@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504081231130.28951@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Fri, 8 Apr 2005, Matthias-Christian Ott wrote:
>  
>
>>But as mentioned you need to _open_ each file (It doesn't matter if it's 
>>cached (this speeds up only reading it) -- you need a _slow_ system call 
>>and _very slow_ hardware access anyway).
>>    
>>
>
>Nope. System calls aren't slow. What crappy OS are you running?
>
>  
>
But they're slower because there're some instances checking them.

>>I hope my idea/opinion is clear now.
>>    
>>
>
>Numbers talk. I've got something that you can test ;)
>  
>
This doesn't mean it's better just because you had the time develope it 
;). But anyhow the folk needs something, they can test to see if it's 
good or not, most don't believe in concepts.

>		Linus
>
>  
>
We will see which solutions wins the "race". But I think you're 
solutions will "win", because you're Linus Torvalds -- the "Boss" of 
Linux and have to work with this system very day (usualy people are 
using what they have developed :)) -- and I have not the time develop a 
database based solution (maybe someone else is interested in developing it).

Matthias-Christian
