Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315425AbSEVWpO>; Wed, 22 May 2002 18:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSEVWpM>; Wed, 22 May 2002 18:45:12 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:7133 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315425AbSEVWpJ>;
	Wed, 22 May 2002 18:45:09 -0400
Date: Wed, 22 May 2002 15:44:01 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org,
        andrea@suse.de, riel@surriel.com, akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <386750000.1022107441@flay>
In-Reply-To: <Pine.LNX.4.33.0205221421180.1531-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If we could get the apps (well, Oracle) to co-operate, we could just use
>> clone ;-) Having this transparent for shmem segments would be really nice.
> 
> The thing is, we won't get Oracle to rewrite a lot for a completely
> threaded system. And clone does _not_ come with a way to share only parts
> of the VM, and never will - that's fundamentally against the way "struct 
> mm_struct" works. 

We're actually playing with Oracle apps - I'm told they already run on threaded
mode on NT ... I personally get the feeling that Oracle's commitment to Linux is 
distinctly half-hearted. The whole support matrix debacle was pretty indicative, 
IMHO. All personal opinion, I speaketh not for IBM.
 
> Oracle is apparently already used to magic shmem-like things, so doing 
> that is probably acceptable to them.

We can but try, but I still think some transparent magic would be implementable.

M.

