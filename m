Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310209AbSCPRHD>; Sat, 16 Mar 2002 12:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310438AbSCPRGy>; Sat, 16 Mar 2002 12:06:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42507 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310209AbSCPRGf>;
	Sat, 16 Mar 2002 12:06:35 -0500
Message-ID: <3C937B82.60500@mandrakesoft.com>
Date: Sat, 16 Mar 2002 12:06:10 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository.
In-Reply-To: <200203161608.g2GG8WC05423@localhost.localdomain> <3C9372BE.4000808@mandrakesoft.com> <20020316083059.A10086@work.bitmover.com> <3C9375B7.3070808@mandrakesoft.com> <20020316085213.B10086@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>On Sat, Mar 16, 2002 at 11:41:27AM -0500, Jeff Garzik wrote:
>
>>I started with Linus's linux-2.4 repo and so did Marcelo.  We 
>>independently checked in 2.4.recent patches (including proper renametool 
>>use), which included the ia64 and mips merges, which added a ton of 
>>files.  
>>
>
>OK, so there is the root cause.  It's time to talk about duplicate changes.
>
[...]

>There are things we can do in BK to deal with this, but they are not easy
>and are going to take several months, is my guess.  I'd like to see if you
>can work around this by avoiding duplicate patches.  If you can, do so, 
>you will save yourself lots of grief.
>
[...]

>You really want to listen to this, I'm trying to head you off from screwing
>up the history.  If you get 300 renames like this, it's almost always a 
>duplicate patch scenario.
>

I know why it happened, silly.

This was just an example of a real world example that actually happened, 
where BK sucked ass :)

Marcelo's BK tree did not exist when I created my marcelo-2.4 tree. 
 marcelo-2.4 repo existed for a while and people started using it.  Once 
Marcelo appeared with his "official" BK tree, people naturally want to 
migrate.  There were two migration paths: (1) export everything to GNU 
patches, or (2) click the mouse 300 times.

So, knowing that duplicate patches are a bad thing helps not in the 
least here...

    Jeff



