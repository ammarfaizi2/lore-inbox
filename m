Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUK2PpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUK2PpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUK2PnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:43:21 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:4804 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261740AbUK2PmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:42:16 -0500
Message-ID: <41AB433C.2030705@namesys.com>
Date: Mon, 29 Nov 2004 07:41:48 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>
CC: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
       Christian Mayrhuber <christian.mayrhuber@gmx.net>,
       reiserfs-list@namesys.com,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <2c59f00304112205546349e88e@mail.gmail.com> <1101287762.1267.41.camel@pear.st-and.ac.uk> <4d8e3fd304112407023ff0a33d@mail.gmail.com> <200411241711.28393.christian.mayrhuber@gmx.net> <1101379820.2838.15.camel@grape.st-and.ac.uk> <41A773CD.6000802@namesys.com> <20041127124937.GO26192@nysv.org>
In-Reply-To: <20041127124937.GO26192@nysv.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Törnqvist wrote:

>On Fri, Nov 26, 2004 at 10:19:57AM -0800, Hans Reiser wrote:
>
>  
>
>>For the case Peter cites, yes, it does add clutter to the pathname to 
>>say "..metas" (actually, it is "...." now in the current reiser4, not 
>>"..metas").  This is because you aren't looking for metafile 
>>    
>>
>
>"...." shound like something that could be an alias for ../..
>so not much better than reserving the word "metas" from the namespace.
>
>I guess I'll still go with ..metas here, as it's the best compromise
>showed. Or maybe even ..meta (as there is no need for the plural imo)
>
>Just re-opening a damned useless, old, tired and daft can of worms :P
>
>  
>
I agree that ..metas is much less likely to cause a namespace collision, 
but I also think that if we called it "john" it would not be a major 
problem, and since the issue is causing us political problems in getting 
into the kernel, "...." is more PR right (as it does not slight Finnish 
women named meta by suggesting they are too obscure to count), and so 
"...." wins.    "...." also has the advantage that it is elegant in 
extending the Unix convention, in that we already have a ".." and a "." 
and hidden files that start with ".".
