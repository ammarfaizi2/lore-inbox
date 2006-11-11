Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424564AbWKKMDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424564AbWKKMDP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 07:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424565AbWKKMDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 07:03:14 -0500
Received: from ns1.suse.de ([195.135.220.2]:16841 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1424564AbWKKMDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 07:03:13 -0500
From: Neil Brown <neilb@suse.de>
To: Willy Tarreau <w@1wt.eu>
Date: Sat, 11 Nov 2006 23:03:17 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17749.48133.47785.477458@cse.unsw.edu.au>
Cc: Randy Dunlap <rdunlap@xenotime.net>,
       Stephen Hemminger <shemminger@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Al Boldi <a1426z@gawab.com>,
       linux-kernel@vger.kernel.org
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
In-Reply-To: message from Willy Tarreau on Saturday November 11
References: <200611090757.48744.a1426z@gawab.com>
	<20061109090502.4d5cd8ef@freekitty>
	<200611101852.14715.a1426z@gawab.com>
	<9a8748490611100816v573418f4gcd5cbe34d0dd3715@mail.gmail.com>
	<4554AC12.6040407@osdl.org>
	<20061110085311.54fd65f2.rdunlap@xenotime.net>
	<20061111071533.GA577@1wt.eu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday November 11, w@1wt.eu wrote:
> On Fri, Nov 10, 2006 at 08:53:11AM -0800, Randy Dunlap wrote:
> > Either that or lkml is/remains for bug reporting and we move development
> > somewhere else.  Or my [repeated] preference:
> > 
> > do development on specific mailing lists (although there would
> > likely need to be a fallback list when it's not clear which mailing
> > list should be used)
> 
> I've been thinking about this too for a while now. There is something
> like half of the email volume which are (semi-)automated emails
> containing patches moving from a GIT tree to another. I think that
> moving this to some linux-dev or something like this would :
> 
>   1) reduce the noise on LKML so that problem reports are better caught
>   2) reduce the global email volume because instead of sending all these
>      emails to 10-20000 persons(?), only maybe a thousand will be subscribed.
>   3) reduce even more the latency between post and publication due to 2.
> 
> I don't know if others would be interested, in which case it would be wise
> to poll on the subject and include Matti and Davem to the discussion.

I personally don't think the volume on lkml is a particular problem.
I have filters which pick out the items that might be of particular
interest to me (matching on words like 'nfs' 'raid' 'md' in my case)
and the rest goes in to a bucket that I glance at occasionally.  When
I do, I scan the subject lines and read the things that seem
interesting at the time, and delete the rest unread.

I prefer this to splitting lkml into multiple lists because it makes
it much easier for me to change my areas of interest from time to
time.  I don't have to go and subscribe to different lists, I just use a
different pattern for matching (either in my brain or in my filter).

I suspect the main reason that I miss problem reports that are
relevant to me is that people choose poor Subject: lines.
e.g. when I scan the subjects of a thread I might see multiple threads
all with 
           Subject: Re: 2.6.18-rc5-mm2
and I'll have no idea what they are really about, and I don't have
time to read them all.   If reporters simple put
                                   (nfs problem)
at the end of the subject (or whatever is appropriate) then it would
be a LOT easier to avoid missing things (some people do do this.  I
see their bug reports promptly when relevant).
Fortunately akpm is very good at reading all of these and forwarding
things as appropriate (thanks Andrew) but that shouldn't really be
necessary.  And that situation won't be improved by reducing traffic
on any list or splitting up the list (there are already plenty of
other lists around).  It really requires people who submit bug reports
to think about what they are doing, and make it easy for people to
find their bug report.

I guess bugzilla encourages people to think about their bug report and
tag it accordingly.  In that sense bugzilla is good.  I just hate
using it - I have to use a web browser, and it feels like a closed,
private discussion, which really isn't appropriate.

NeilBrown
