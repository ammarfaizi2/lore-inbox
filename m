Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135216AbREICdK>; Tue, 8 May 2001 22:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135789AbREICdA>; Tue, 8 May 2001 22:33:00 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:32682 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S135216AbREICcx>;
	Tue, 8 May 2001 22:32:53 -0400
Date: Tue, 8 May 2001 22:31:23 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: <netdev@oss.sgi.com>
cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.rutgers.edu>,
        Sally Floyd <floyd@aciri.org>, <kk@teraoptic.com>, <jitu@aciri.org>
Subject: ECN: Volunteers needed
Message-ID: <Pine.GSO.4.30.0105082145200.447-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Folks,

ECN is about to become a Proposed Standard RFC. Thanks to
efforts from the Linux community, a few issues were discovered
in the course of deploying the code. Special kudos go to Alexey
Kuznetsov and David Miller.

I wont go into details of the issues other than to say some
midlle-box vendors in the past have associated the semantics of the
natural-language English word "reserved" to have a different meaning.
visit Jeff Garzik's ECN-under-Linux Unofficial Vendor Support Page
at: http://gtf.org/garzik/ecn/ for more details

Sally Floyd explains best why it is wrong for vendors of middle boxes to
be doing this in the draft to be found at:
ftp://ftp.normos.org/ietf/internet-drafts/draft-floyd-tcp-reset-00.txt

So why am i posting this?

This is to solicit volunteers who will help removing the remaining cruft.
Some vendors (special positive mention goes to CISCO) have released
patches which are unfortunately not being propagated by some of the
site owners.
Help is needed to contact these site owners and politely using a standard
email ask them that their site was non-conformant.
Point them to Sally's draft and the fact that ECN is becoming standard
in the next week or so. Also to Jeff's ECN-under-Linux Unofficial
Vendor Support Page, and to encourage them to have their firewall
or load-balancer upgraded.
I suppose the first volunteer needed is to draft such an email. We have to
be polite and persistent for this to work.

Jitendra Padhye at ACIRI is running weekly tests to detect offending
sites. Most recent results can be found at:
http://www.aciri.org/tbit/ecn_test3A.html
Any site with the word "RST" on the line should be considered
non-conformant.

Volunteers please send an email to ecn@gtf.org with subject "interested in
volunteering"

Flames etc please redirect to netdev (since that's the only list i am on).
as well make sure you cc the other people (other than linux-kernel and
linux-net)

cheers,
jamal



