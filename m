Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbTABAYr>; Wed, 1 Jan 2003 19:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbTABAYr>; Wed, 1 Jan 2003 19:24:47 -0500
Received: from franka.aracnet.com ([216.99.193.44]:27337 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265247AbTABAYo>; Wed, 1 Jan 2003 19:24:44 -0500
Date: Wed, 01 Jan 2003 16:32:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
       Dave Jones <davej@codemonkey.org.uk>,
       "Timothy D. Witham" <wookie@osdl.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Raw data from dedicated kernel bug database
Message-ID: <25830000.1041467574@titus>
In-Reply-To: <20030101221510.GG5607@work.bitmover.com>
References: <20030101194019.GZ5607@work.bitmover.com>
 <12310000.1041456646@titus> <20030101221510.GG5607@work.bitmover.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm not sure how other people feel about exporting stuff into bitkeeper
>> type-licensed products ... if the non-BK people like Alan and Andrew, and
>> the other people who've done lots of the work in the DB like Dave and
>> Randy,
>> and the OSDL are OK with it, then I'd be willing to help. If they object,
>> then probably not.
>
> This raises the question of who owns the data in the bug database
> hosted by OSDL/IBM.  It seems questionable that you would even consider
> restricting access to it.  Not even sourceforge does that, you can ftp
> the CVS tarballs, they build them nightly.  If you are going to restrict
> access to the data for political reasons I find it difficult to believe
> that your database is going to gain any real traction.

I didn't say I was going to restrict access to it. I said that depedant
on the feeling of the community, I would or would not help you automate
things. Moreover, I think I was reasonably clear it wasn't really my
opinion on the subject I was going on, it was that of the community.

Who owns the data is indeed an interesting question. I'd say it's owned
by the community, but that's not very helpful in practice. If we have to
get all explicit about things, it should probably fall under some GPL type 
license. My first gut-feeling impression of a general priniciple is that
if you copy the data and make changes to it, you should have to make
those changes available back to people (without using non-GPL (or
similar) tools). But that's not explicitly stated at the moment - if it
needs to be, then I guess I'll try to get some consensus on exactly what 
people want.

> We're not proposing to replace the OSDL bug database, we're proposing
> to mirror it.  Exactly the same way as people mirror the BK trees into
> patches, CVS, SVN, whatever.  Doesn't it seem strange to you that the
> so-called non-free BK data is freely available but the free bug data
> is not freely available?  Sounds pretty unfree to me but I'll leave
> it to the community to decide whether they want the data locked up in
> politically correct tools.

My objection is more pragmatic actually - I don't want to do anything
that pisses off the people who won't touch BK enough that they feel
the need to create their own database, and split the effort in twain.
As I said before, I don't want to end up with multiple databases with
distinct sets of data in them ... I'll do what I can to avoid that.

I thought the data in BK was always free, I never personally called
that into question - the minute that is no longer true, I think we
have a much larger problem on our hands. In reply to the "sounds pretty
unfree to me" comment, you could apply much the same argument to the
GPL - you can't copy that code into anywhere you please and do anything
you like with it. But ultimately I agree with your final sentence, it's
up to the community.

> Some clarification is probably in order.  Does IBM or OSDL think they
> have a copyright on the bug data?  I don't remember any discussion of
> that and http://www.osdl.org/legal/ip_policy.html seems to suggest that
> the bug data is not considered OSDL IP.  If you're not going to make
> the data easily available it's not that hard to make a one way bridge
> using wget but if you think that data is copyrighted I'm sure that I'm
> not the only one who would like to know about that.

I don't know of any copyright claims on the current data, nor would I
like to see one that restricted future data to either IBM and/or OSDL.

> A bug database that only IBM can really use, at the DB level, seems
> like a pretty unopen and unfree thing.  If it's supposed to support the
> open source developers shouldn't they all be able to get at the data?
> In any way they find useful?  What if Red Hat wants access to the SQL
> data because it is too big to manage through web forms?  Do they get it?
> What about all the other companies?  If the position is that you get to
> pick and choose who gets at the real data then I can promise you someone
> else will start hosting a database with far more open rules.  I'll do
> it if noone else does.  The data should be freely accessible in the
> most reasonable form.  The GPL was very careful to not allow people to
> pretend to conform by providing the source in anything but the most
> useful form, it would seem that you should conform to those rules.
> If you aren't going to, please tell us.

Errm ... now you're getting way off base. For one, this has very little,
if anything at all, to do with IBM. Anything I've posted thus far on
this topic is my own personal opinion, and I've repeatedly made it clear
that I'm looking for community opinion on the matter. This is community
project, not an IBM database, and I've made that very clear to people
inside as well as outside of IBM. If other people hate the idea of
exporting the data they filed, processesed and manged to BK, then I'm
not going to spend my time helping you.

Given there's no real licensing on the current data, I'm not going to
stop you doing a wget of the current data. If the community seems to
want it, I'll look at putting some sort of license agreement on future
data. I don't feel desperately obliged to export things for you in a
form that happens to be more convenient to you than the access everybody
else has, but if people in the community that I respect tell me they think
I should, I'll probably try.

However, before everyone summons a gaggle of lawyers to start bickering
about details of all this ... can we see if we can just work out how to
get along just fine? Assuming people don't object massively to you
pulling the data into BK, what added value can we get from that integration,
and how are we going to make it available back to the community? What data
are you looking at appending to each bug, and at what cycle in the process?
Do you want to add information when a (supposed) fix is checked in? Anything
else?

M.

