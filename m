Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267837AbTAMLCl>; Mon, 13 Jan 2003 06:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267839AbTAMLCl>; Mon, 13 Jan 2003 06:02:41 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27953 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267837AbTAMLCk>; Mon, 13 Jan 2003 06:02:40 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Love <rml@tech9.net>, Rob Wilkens <robw@optonline.net>,
       Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
References: <Pine.LNX.4.44.0301121231010.14031-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Jan 2003 04:09:41 -0700
In-Reply-To: <Pine.LNX.4.44.0301121231010.14031-100000@home.transmeta.com>
Message-ID: <m14r8dgvbe.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 12 Jan 2003, Robert Love wrote:
> > On Sun, 2003-01-12 at 15:22, Linus Torvalds wrote:
> > 
> > > No, you've been brainwashed by CS people who thought that Niklaus
> > > Wirth actually knew what he was talking about. He didn't. He
> > > doesn't have a frigging clue.
> > 
> > I thought Edsger Dijkstra coined the "gotos are evil" bit in his
> > structured programming push?
> 

Actually Edsger Dijkstra wrote a paper entitled "Goto considered Harmful"
He never called them evil.  And the title was more for shock value to
grab peoples attention.  For the beginners Dijkstra did not
distinguish between goto, break, return, and continue.

You can find many of his papers at:
http://www.cs.utexas.edu/users/EWD/

What he was after was simple and maintainable code, and from
everything I have read, I think he would have no major problems with
the Linux kernel code. 

In the category of maintainability, and simplicity Dijkstra made
certain the first hardware implementation of an interrupt handler he
worked with had the ability to completely save the interrupt state so
he could later return to the interrupted code.  To make writing to a
printer a non-realtime task he invented the semaphore. 

> Yeah, he did, but he's dead, and we shouldn't talk ill of the dead.

Linus I think if he was alive you would have enjoyed talking to him,
your view points seem to mesh quite well.

>  So 
> these days I can only rant about Niklaus Wirth, who took the "structured 
> programming" thing and enforced it in his languages (Pascal and Modula-2), 
> and thus forced his evil on untold generations of poor CS students who had 
> to learn langauges that weren't actually useful for real work.

Now that is something worth criticizing! 

Though standard Pascal was not unusable because of the lack of a goto,  
that was the one feature it actually had.  But I suspect a lot of
teachers failed to mention it.

> 
> (Yeah, yeah, most _practical_ versions of Pascal ended up having all the 
> stuff necessary to break structure, but as you may be able to tell, I was 
> one of the unwashed masses who had to write in "standard Pascal" in my 
> youth. I'm scarred for life).


Well you seem to be coping well.  Just a little Pascal phobia there...

Eric


