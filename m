Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131480AbQKJTsZ>; Fri, 10 Nov 2000 14:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131528AbQKJTsF>; Fri, 10 Nov 2000 14:48:05 -0500
Received: from [213.8.184.211] ([213.8.184.211]:53766 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S131480AbQKJTr4>;
	Fri, 10 Nov 2000 14:47:56 -0500
Date: Fri, 10 Nov 2000 21:46:52 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: George Anzinger <george@mvista.com>
cc: Ivan Passos <lists@cyclades.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Patch generation
In-Reply-To: <3A0C2813.E7CB42D2@mvista.com>
Message-ID: <Pine.LNX.4.21.0011102139170.21416-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, George Anzinger wrote:

> > 4 kernel trees, one after make dep ; make bzImage, and all taking together
> > just 193MB, instead of about 400MB... hard links, gotta love'em.
> 
> Ok, this is cool, but suppose I have the same file linked to all these
> and want to change it in all the trees, i.e. still have one file.  Is
> there an editor that doesn't unlink.  Or maybe cp of the edited file?? 
> How would you do this?  (I prefer EMACS, which likes to unlink.)

I know mcedit doesn't unlink (but mcedit kinda sucks), I think nedit
doesn't unlink too.

I prefer an editor that unlinks, since in most cases I don't want to
modify the source trees that I'm not working on, so diff can do what it's
supposed to do later.

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
