Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293035AbSCOSQs>; Fri, 15 Mar 2002 13:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293041AbSCOSQk>; Fri, 15 Mar 2002 13:16:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45317 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293035AbSCOSQa>;
	Fri, 15 Mar 2002 13:16:30 -0500
Message-ID: <3C923A6A.2030905@mandrakesoft.com>
Date: Fri, 15 Mar 2002 13:16:10 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 and BitKeeper
In-Reply-To: <3C90E994.2030702@candelatech.com> <3C90E994.2030702@candelatech.com> <2865.1016190641@redhat.com> <20020315080408.D11940@work.bitmover.com> <a6tcnf$shg$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>Right now simple things like command-line completion and
>
>	find . -name '*.[chS]' | xargs grep xxxx
>
>do not work, because they either don't find files or they find the wrong
>ones (the internal bitkeeper files etc). 
>


I always check out my trees with "bk -r co -q" precisely because of 
command-line completion.  Anything that saves my poor hands from further 
pain is a good thing... :)  And similar to your example, I switched from 
my preferred method of search, grep -r, to /usr/bin/find, just so I 
would (and had to) add "grep -v SCCS" in the middle of the xargs pipe.

    Jeff




