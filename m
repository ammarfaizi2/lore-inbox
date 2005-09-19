Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVISA47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVISA47 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 20:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVISA47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 20:56:59 -0400
Received: from qproxy.gmail.com ([72.14.204.201]:5616 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932282AbVISA46 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 20:56:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=reXtmlkuilxcUsERQSRWi+cOOYr3BSH77mLI6qpCyCYVwxmdHkvB6FUf5k2u/Xys/gIAKEU/AoVx4MAuDlcGQ2WEFp3R3axv2ndLBJICVcPEwWezFCspe8hsIfFMa64nELWXpT9Q++7fCLzrIP3gA4OCD3lY8pv9h3JuwafS/vg=
Message-ID: <b14e81f00509181756275e435c@mail.gmail.com>
Date: Sun, 18 Sep 2005 20:56:57 -0400
From: michael chang <thenewme91@gmail.com>
Reply-To: thenewme91@gmail.com
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Cc: Christoph Hellwig <hch@infradead.org>, Denis Vlasenko <vda@ilport.com.ua>,
       chriswhite@gentoo.org, Hans Reiser <reiser@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <D039E613-2D78-4034-A1E9-8D21DCE796E3@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <432AFB44.9060707@namesys.com>
	 <200509171415.50454.vda@ilport.com.ua>
	 <200509180934.50789.chriswhite@gentoo.org>
	 <200509181321.23211.vda@ilport.com.ua>
	 <20050918102658.GB22210@infradead.org>
	 <b14e81f0050918102254146224@mail.gmail.com>
	 <D039E613-2D78-4034-A1E9-8D21DCE796E3@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/05, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> On Sep 18, 2005, at 13:22:27, michael chang wrote:
> > On 9/18/05, Christoph Hellwig <hch@infradead.org> wrote:
> >
> >> On Sun, Sep 18, 2005 at 01:21:23PM +0300, Denis Vlasenko wrote:
> >>
> >>> This is it. I do not say "accept reiser4 NOW", I am saying "give
> >>> Hans good code review".
> >>
> >> that and there's much more exciting filesystems like ocfs2 around
> >> that
> >
> > This is exciting to... whom?
> 
> To the people that review the code.  We're all volunteers here; if
> your filesystem is so ugly and hard to read that the code reviewers
> don't feel like finding time to slog through the mess, then it
> probably means that you need to clean the code, document it better,
> make it simpler to understand, fix the coding-style, etc.
> 
> > The only thing that appears remotely interesting about it is that
> > it's made by Oracle and apparently is supposed to be geared toward
> > parallel server whatsits.  This might be helpful to corporations,
> > but seems senseless toward many consumers.  (I'm assuming there's
> > still at least one consumer left who still uses Linux.)
> 
> Like I said above, we're all volunteers.  Personally, I find OCFS2
> _much_ more interesting than reiser4, because it has a lot of cool
> networked lock-managing algorithms that (given my current limited
> understanding), work black magic.  Given this, I'm a lot more likely
> to spend time reading the OCFS2 code because its interesting than I
> am reading reiser4 code, even though somebody eventually probably
> needs to do said review.  Hans' personal attacks on the people who
> have criticized his code make such tasks even less personally
> gratifying (IE: less interesting).  I think some people are likely
> hoping right now that if they put off the reiser4 code review long
> enough, maybe the authors will take a hint and have it a bit cleaner
> by the time they finally do get around to the review.
> 
> > Give Hans a chance; and please try to understand, even if he's hard
> > to work with.  Discriminate him because he's not a developer you
> > can talk with, and I believe that's like discriminating a guy in a
> > wheelchair because he can't run with you when you jog in the morning.
> 
> When you start getting into obscure discrimination analogies, the
> discussion has become _way_ nontechnical.  If this goes this goes any
> further, somebody's probably going to compare a kernel developer to a
> Nazi or Hitler, invoking Godwin's law and effectively killing the
> thread.  Please get this back onto a technical bent or drop it.
> 
> > Not everyone has the same "common sense" that you do.  Explain,
> > fully, with reasoning, and reproducable back-up statistics on
> > common hardware, what code is wrong, and what must be written
> > instead.  We'd like to be efficient, and it's not being efficient
> > to play a guessing
> > game with us.  If you don't have the time to review, then please
> > hold  off on replying until you have a through review of at least
> > part of the code.
> 
> Christoph has noted a number of things in previous emails.  I just
> looked through the latest released code and several of them are still
> valid.  I would look through the latest code to see what is still
> missing, but I can't get it on account of it being in bitkeeper,
> which I don't have installed and don't intend to install.
> 
> > I'm willing to go compare...  [massive nontechnical rhetoric snipped]
> 
> Unless you have technical arguments to contribute (and you indicate
> that you do not), please to not spam the LKML with useless rhetoric-
> filled emails that most of us will delete because we have too many
> other things to do to bother reading or responding to.
> 

Alright, I concede.

Personally, I'm not much of a techie compared to you guys; I'm only in
High School, and I have a mental disorder
(http://en.wikipedia.org/wiki/Asperger's_Syndrome), so I'll stop here,
and hope that you guys can resolve this yourselves.  Good luck to all,
and hopefully there will be a peaceful resolution here.

-- 
~Mike
 - Just my two cents
 - No man is an island, and no man is unable.
