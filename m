Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290962AbSAaGDl>; Thu, 31 Jan 2002 01:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290963AbSAaGDc>; Thu, 31 Jan 2002 01:03:32 -0500
Received: from rj.SGI.COM ([204.94.215.100]:39330 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S290962AbSAaGDV>;
	Thu, 31 Jan 2002 01:03:21 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Larry McVoy <lm@bitmover.com>
Cc: Rob Landley <landley@trommello.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin 
In-Reply-To: Your message of "Wed, 30 Jan 2002 21:55:23 -0800."
             <20020130215523.G18381@work.bitmover.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 Jan 2002 17:03:11 +1100
Message-ID: <9787.1012456991@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002 21:55:23 -0800, 
Larry McVoy <lm@bitmover.com> wrote:
>On Thu, Jan 31, 2002 at 04:46:43PM +1100, Keith Owens wrote:
>> When I release a patch I pick a start
>> point (base 2.4.17, patch set 17.1) and an end point (kdb v2.1 2.4.17
>> common-2, patchset 17.37) and prcs diff -r 17.1 -r 17.37.  
>
>bk export -tpatch -r17.1,17.37
>
>Does exactly the same thing.

Now you've confused me :).  Does that replicate the history or not?

I know that bk can generate a patch which is fine for people not using
bk, but one of the selling points of bk is the ability to replicate
history entries.  My point is that full replication of history may be
too much detail for anybody except the original developer.  If bk can
consolidate a series of patchsets into one big patchset (not patch)
which becomes the unit of distribution then the problem of too much
history can be solved.

