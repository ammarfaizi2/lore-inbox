Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311046AbSCMTS6>; Wed, 13 Mar 2002 14:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311039AbSCMTSt>; Wed, 13 Mar 2002 14:18:49 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:34054 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S311035AbSCMTSi>; Wed, 13 Mar 2002 14:18:38 -0500
Message-ID: <3C8FA608.6040103@namesys.com>
Date: Wed, 13 Mar 2002 22:18:32 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
CC: Larry McVoy <lm@work.bitmover.com>,
        Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        James Antill <james@and.org>, Larry McVoy <lm@bitmover.com>,
        Tom Lord <lord@regexps.com>, jaharkes@cs.cmu.edu,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <20020312223738.GB29832@pimlott.ne.mediaone.net> <Pine.GSO.4.21.0203131037240.17582-100000@vervain.sonytel.be> <20020313143720.GA32244@pimlott.ne.mediaone.net> <20020313082647.Y23966@work.bitmover.com> <20020313163045.GA6575@pimlott.ne.mediaone.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Pimlott wrote:

>On Wed, Mar 13, 2002 at 08:26:47AM -0800, Larry McVoy wrote:
>
>>On Wed, Mar 13, 2002 at 09:37:20AM -0500, Andrew Pimlott wrote:
>>
>>>Also, you can use ClearCase without the filesystem (snapshot view)
>>>and get all the same functionality.
>>>
>>Are you sure about that?  Snapshots are just the cleartext files.  The
>>set of operations you can do with a disconnected snapshot is extremely
>>limited, last I checked all you could do was edit the files.
>>
>
>Right, if you're disconnected from the network, that's all you can
>do (and it sucks, because if you haven't already checked out the
>file you want to edit, you have to "hijack" it, and clearcase deals
>with hijacks in a braid-dead way).
>
>But if you're on the network, you can use a snapshot view in the
>same way as a dynamic view.  You just don't get a "real-time" view
>of the repository and the magic foo.c@@/ directories.  (It has the
>advantages that you can take it off the network and still have some
>limited functionality; it's faster; and you don't have to run an old
>Linux kernel and binary modules.)
>
>So to be clear, I was definitely talking about using a snapshot view
>while connected to the clearcase servers.  In this case, you can do
>everything you could do in a dynamic view.
>
>Andrew
>
>
You are right that you aren't going to convince me.  I was a clearcase 
administrator, and I don't understand you at all.  Using the network, 
using an API in addition to VFS, using another filesystem as an 
underlying cache, none of these things make it any less part of the 
filesystem.

Hans

