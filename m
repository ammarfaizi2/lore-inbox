Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267441AbTALTte>; Sun, 12 Jan 2003 14:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267440AbTALTtd>; Sun, 12 Jan 2003 14:49:33 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:4458 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S267442AbTALTta>; Sun, 12 Jan 2003 14:49:30 -0500
Message-ID: <3E21C8D5.5010301@blue-labs.org>
Date: Sun, 12 Jan 2003 14:58:13 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030110
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: robw@optonline.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <20030112194100.A15036@infradead.org> <1042400474.3162.32.camel@RobsPC.RobertWilkens.com>
In-Reply-To: <1042400474.3162.32.camel@RobsPC.RobertWilkens.com>
X-Enigmail-Version: 0.71.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The horrific response to the use of "goto" is deprecated in favor of 
proper use.  A function overloaded with gotos probably should be 
reworked.  But there there is no need to outright avoid the use of 
'goto'.  if()  is simply a conditional test with a goto A or goto B logic.

There is a reason for the implementation of goto.  When it all boils 
down to it, in assembler it's all a matter of JMP with or without a 
condition.

David

Rob Wilkens wrote:

>On Sun, 2003-01-12 at 14:41, Christoph Hellwig wrote:
>  
>
>>On Sun, Jan 12, 2003 at 02:34:54PM -0500, Rob Wilkens wrote:
>>    
>>
>>>Linus,
>>>
>>>I'm REALLY opposed to the use of the word "goto" in any code where it's
>>>not needed.
>>>      
>>>
>>Who cares?
>>
>>    
>>
>
>I do.
>
>-Rob
>  
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+IcjV74cGT/9uvgsRAtPFAKDATzN7dkRyfRk7WXEDGyYe0oGiqACffj+X
iXkDBQntdGnHeJFKjfmp0Lg=
=l9hb
-----END PGP SIGNATURE-----

