Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267323AbSLRSj7>; Wed, 18 Dec 2002 13:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267324AbSLRSj7>; Wed, 18 Dec 2002 13:39:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18098 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267323AbSLRSj5>;
	Wed, 18 Dec 2002 13:39:57 -0500
Message-Id: <200212181847.gBIIlhO26530@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Hans Reiser <reiser@namesys.com>
cc: Andrew Morton <akpm@digeo.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>,
       cliffw@osdl.org
Subject: Re: [Benchmark] AIM9 results 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Tue, 17 Dec 2002 03:00:13 +0300." <3DFE690D.7000602@namesys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 Dec 2002 10:47:43 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew Morton wrote:
> 
> >Andrew Morton wrote:
> >  
> >
> >>Hans Reiser wrote:
> >>    
> >>
> >>>Andrew and Chris, are these changes in performance definitely due to VM
> >>>changes (and not some difference I am not thinking of between 2.5 and
> >>>2.4 reiserfs code)?
> >>>
> >>>      
> >>>
> >>aim9 is just doing
> >>
> >>        for (lots)
> >>                close(creat(filename))
> >>    
> >>
> >                  unlink(filename);	/* of course */
> >
> >
> >  
> >
> Oh, commercial fs vendors must really love tuning for this benchmark.... 
> sigh....
> 
Ya, we think the AIM stuff is getting a little old. The basic idea is fine, but
many of the tests do _very little work.  We (OSDL) would like to re-do 
AIM9+7 and make it more useful. We'd love to have some input from everyone....
For example, how big a file should we create for a real creat() test ?
cliffw

> Hans
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


