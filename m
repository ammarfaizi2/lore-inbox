Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129896AbRAGJeQ>; Sun, 7 Jan 2001 04:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130119AbRAGJd4>; Sun, 7 Jan 2001 04:33:56 -0500
Received: from mail006.syd.optusnet.com.au ([203.2.75.230]:40912 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S129896AbRAGJdz>; Sun, 7 Jan 2001 04:33:55 -0500
Date: Sun, 7 Jan 2001 20:43:12 +1100 (EST)
From: Brett <bpemberton@dingoblue.net.au>
To: Matthias Juchem <juchem@uni-mannheim.de>
cc: Ulrich Drepper <drepper@cygnus.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new bug report script
In-Reply-To: <Pine.LNX.4.30.0101070858400.7104-100000@gandalf.math.uni-mannheim.de>
Message-ID: <Pine.LNX.4.21.0101072041380.12767-100000@tae-bo.generica.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, Matthias Juchem wrote:

> On 6 Jan 2001, Ulrich Drepper wrote:
> 
> > This is wrong.  You cannot execute libc.so.5.  This only works with
> > glibc.
> 
> I already thought of something like that (I was not able to test it...).
> Can you tell me a reliable way to get the version other than just looking
> for the version appended to the file name?
> Or is the file name scheme reliable (/lib/libc.so.5.x.y)?
> 

Taking a guess here....

strings /lib/libc* | grep "release version"

I'm not sure how reliable this method is either :)

	/ Brett

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
