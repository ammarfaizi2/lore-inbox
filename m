Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbUJWWDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbUJWWDx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 18:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUJWWDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 18:03:53 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:12910 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261316AbUJWWDu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 18:03:50 -0400
Subject: Re: 2.6.9-mm1
From: Kasper Sandberg <lkml@metanurb.dk>
To: Avuton Olrich <avuton@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <3aa654a404102300221317f104@mail.gmail.com>
References: <20041022032039.730eb226.akpm@osdl.org>
	 <3aa654a404102300221317f104@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 24 Oct 2004 00:03:48 +0200
Message-Id: <1098569028.18992.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ey, i'd like to see it in the kernel too, i have seen people have
issues, and people have also told me that i should be scared of losing
my data, i have been using reiser4 since 2.6.5, and i have had servers
running it (well not any servers with extremely high load though), and
my workstation has it on a partition where i keep misc stuff, and this
is also where i do alot of conversions of movies, with transcode, and
alot other stuff, so it sure has alot activity, however, not a single
problem... i think its perfectly fine enough to go into the kernel,
atleast as marked EXPERIMENTAL, i would rather place my data on reiser4,
than ext3, according to my experiences (and i do this too)

On Sat, 2004-10-23 at 00:22 -0700, Avuton Olrich wrote:
> On Fri, 22 Oct 2004 03:20:39 -0700, Andrew Morton <akpm@osdl.org> wrote:
> 
> >   - reiser4: not sure, really.  The namespace extensions were disabled,
> >     although all the code for that is still present.  Linus's filesystem
> >     criterion used to be "once lots of people are using it, preferably when
> >     vendors are shipping it".  That's a bit of a chicken and egg thing though.
> >     Needs more discussion.
> 
> *Disclamer: My first post to the list, sorry if something's wrong with
> it (blame gmail ;P)*
> 
> I've been using reiser4 in four of my computers since it was in -mm.
> All partitions (excl. /boot), including 2 boxes that have been up
> since (well, reboots for -mm updates from time to time) the reiser4
> conversion and not a hiccup since. I'm always shocked when people
> speak about how my computers are going to blow up, how people who run
> reiser4 must be insane, etc... I've heard it all. Truth is, at the end
> of the day, me, Joe End User, has had no issues. I'm not here to say
> it's perfect (only the programmers know for sure, IANAP), but it's far
> from unpredictable.
> 
> The fs's have taken their share of beatings too, testing the new ACPI
> stuff lately has lead to plenty of lockups and reiser4 deals much
> better than filesystems I have played with in the past.
> 
> What I'm trying to say here is I've seen more instability in other
> places in the kernel lately than I've seen come from reiser4 at all.
> What hurts when including it, when people have the choice not to
> compile in and have the big EXPERIMENTAL warning?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

