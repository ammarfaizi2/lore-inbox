Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287260AbRL2XvS>; Sat, 29 Dec 2001 18:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287250AbRL2XvI>; Sat, 29 Dec 2001 18:51:08 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:10382 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287257AbRL2Xuv>; Sat, 29 Dec 2001 18:50:51 -0500
Date: Sat, 29 Dec 2001 18:50:49 -0500
From: Atomic Killer Attack Fish <bcrl@redhat.com>
To: Dave Jones <davej@suse.de>, Larry McVoy <lm@bitmover.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011229185049.B9965@redhat.com>
In-Reply-To: <20011229151440.A21760@work.bitmover.com> <Pine.LNX.4.33.0112300027400.1336-100000@Appserv.suse.de> <20011229153840.C21760@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011229153840.C21760@work.bitmover.com>; from lm@bitmover.com on Sat, Dec 29, 2001 at 03:38:40PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 03:38:40PM -0800, Larry McVoy wrote:
> In my message above, I specifically asked about any one area, asking if 
> there was parallel development in that area.  So far, noone has said "yes".
> If the answer was "yes", somebody in your fanin (nice ascii, BTW :) is
> merging.  So the answer is either
> 
> 	noone => no parallel development in any one area
> or
> 	someone
> 
> If it is "someone", who is it?

Going back to your original message, the majority of development is 
occurring in parallel: networking, sound, video, scsi... all those 
drivers are completely independant from the changes to the core kernel 
(modulo occasional major changes), and tend not to have conflicts when 
they reach the mainstream kernel (maintainers tend to sort that out).  

That said, some areas (like VM) are being touched by multiple people, 
but we usually don't touch things in a way that conflicts with each 
other (just occasionally).  Instead, the typical problem is tracking 
the state of all the changes and knowing where things are being delayed 
or dropped (and why).  Is that a sociological problem or a development 
problem?  Does it need to be solved with people or tools?  I don't know 
the answer to those questions or the right mix between the two answers.  
Certainly, a set of tools that helps avoid these issues by making sure 
the first level of problems (merging, test compile, basic testing) 
would be a great advancement in productivity for those of us who work 
that way, but if the underlying problem is social, it's not going to 
help overall.


		-ben
-- 
Fish.
