Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTF0HpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 03:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTF0HpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 03:45:09 -0400
Received: from mail.zmailer.org ([62.240.94.4]:63981 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S262318AbTF0HpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 03:45:01 -0400
Date: Fri, 27 Jun 2003 10:59:14 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "David S. Miller" <davem@redhat.com>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
Message-ID: <20030627075914.GO28900@mea-ext.zmailer.org>
References: <20030626.223002.21926109.davem@redhat.com> <18330000.1056692768@[10.10.2.4]> <20030626.224739.88478624.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030626.224739.88478624.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 26, 2003 at 10:47:39PM -0700, David S. Miller wrote:
>    From: "Martin J. Bligh" <mbligh@aracnet.com>
>    Date: Thu, 26 Jun 2003 22:46:10 -0700
>    
>    If people choose to file bugs in bugzilla as well, they'll still be
>    processed by someone.
> 
> Just so that someone can post them to the lists?
> That sounds like a completely silly way to operate.
> 
> I'd rather they get posted to the lists _ONLY_.

I have recently pondered usage of Request Tracker  for this
kind of tasks.   The problem with "post to the list" is that
sometimes things slip thru without anybody catching them.

Integrating  linux-kernel  and  RT ...   urgh..  result would
be quite ugly.  (Flame wars and out-of-topic threads going on
as requests...)

> This way not that "someone", but "everyone" on the lists
> can participate and contribute to responding to the bug.

That needs merely message arriving to the list.
Ok, responding so that the response appears also
at the bug db is another story.

> The only way you can make things scale is if you throw a group
> of people into the collective of folks able to respond to a problem.
> 
> If it all gets filtered through by one guy, THAT DOES NOT WORK.
> That one guy limits what can be done, and when he's busy one day
> or he goes away on vacation for a while, the whole assembly
> line stops.

Bugzilla could be adapted to this use:
  - Bugs are to be assigned to, e.g.   linux-net/netdev   list
  - Everybody can comment on them at bugme (after signing on)
  - Only some meta-admin (and original bug creator) can
    alter status (e.g. mark as RESOLVED)

Having plenty of bugme group admins (half a dozen or so) to do
the initial bugzilla assigment work, those people taking the task
seriously, and everybody of them going en masse to assign arrived
things.  That way people can have time off - as long as they
coordinate among themselves.

The minus (and plus) is, of course, that the entire discussion
flowing at the list doesn't go to the bug database, but that
doesn't invalidate mechanisms existence as a way to avoid
slipping things thru the cracks.

> Therefore, please eliminate the networking category on bugme.osdl.org
> and we'll process bug reports on the lists so that not _ONE_ but the
> whole community of networking developers can look at the bug.

I thought you don't need to login to see things in bugzilla ?
.. and proved it by looking into bugme..
   http://bugme.osdl.org/show_bug.cgi?id=853

In addition to assinging an OWNER to the bug, there should be
automatic assignment of   linux-net  or  netdev   as  Cc,  IMO...
That will handle the "publish widely" issue that DaveM is
complaining about.

/Matti Aarnio
