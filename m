Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbSKRRM7>; Mon, 18 Nov 2002 12:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSKRRM7>; Mon, 18 Nov 2002 12:12:59 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:29411 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263105AbSKRRM6>;
	Mon, 18 Nov 2002 12:12:58 -0500
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
To: Larry McVoy <lm@bitmover.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Larry McVoy <lm@bitmover.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFA53C05E4.3A74A1DA-ON85256C75.005D75FE@pok.ibm.com>
From: "Khoa Huynh" <khoa@us.ibm.com>
Date: Mon, 18 Nov 2002 11:19:36 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 11/18/2002 12:19:40 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Larry McVoy wrote:

>That's the goal.  I'm hacking on it it currently, we have some issues with
>how it works today, I'll try and get a bk-3.0.1 release out the door which
>fixes them.
>
>The current format is may be seen with a
>
>            bk changes -k -r<rev>
>
>where <rev> is the changeset revision you want.  You'll get something like
>this:
>
>            torvalds@home.transmeta.com|ChangeSet|20021115061315|00914
>
>That's sort of big and ugly, and it currently doesn't work as a name
>in BK/Web.  I'm debugging an implementation of md5 sums of the above
>to see if we can use that instead.  I'll let you know as soon as I
>have something which works.
>
>Assuming that we get some format like dSD4okOiGmLGDcqOTpQPFQ== then
>you'll be able to view the cset with the following URL
>
>
http://linux.bkbits.net:8080/linux-2.5/cset@dSD4okOiGmLGDcqOTpQPFQ==
>
>and that will always work and never get you different data.

Thanks.  Back when we were setting up the OSDL kernel bugzilla, I thought
about having a direct, unique URL link between the bugzilla bug reports
and csets in BK, but could not find anything -- like you said, the revs
changes as you move the changesets from one repository to another.  So
I am very happy that you are going to provide a unique URL link for each
cset.  Please let me know when you get this done and we will have
a separate field (called "Changeset Link") in kernel bugzilla to hold this.

We expect that bug owners, after putting their patches into BK, will obtain
the cset "name", and enter it into the "Changeset Link" field in the bug
report.  After hitting the "Commit" button, the kernel bugzilla will
translate the cset "name" into a URL link like you indicated above.

This would allow people to view bugs, and if there are already fixes in
BK for those bugs, they can get directly to the fixes (changesets).

Khoa


