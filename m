Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270219AbTHFQcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270206AbTHFQct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:32:49 -0400
Received: from caipirinha.heise.de ([193.99.145.36]:40915 "EHLO
	caipirinha.heise.de") by vger.kernel.org with ESMTP id S270219AbTHFQbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:31:43 -0400
Date: Wed, 6 Aug 2003 18:31:31 +0200 (CEST)
From: Juergen Schmidt <ju@heisec.de>
X-X-Sender: ju@loki.ct.heise.de
To: linux-kernel@vger.kernel.org
Subject: security advisories for the kernel
Message-ID: <Pine.LNX.4.44.0308060934480.3262-100000@loki.ct.heise.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19kRCG-0006lX-00*RL4IEhCj6iE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

please regard the following as a request for discussion.

I lately run into a lot of security advisories for the linux kernel 2.4.21
that appeared significantly *after* the release of the kernel itself.
There were

- the problem with the kernel nfsd (DoS, published 29.7.03, fixed in 2.4.21)

- a whole bunch of minor problems (/proc/tty/driver/serial, spoofing
forwarding tables, reuse flag,... published ~20.7.03, fixed in 2.4.21?)

- 2 problems in the netfilter code (DoS, published 2.8.03, fixed in
2.4.21)

AFAIK none of them was announced by an advisory at the time 2.4.21 was
released in June. imho this is a bad thing !


When 2.4.21 was released, I decided not to upgrade, because I saw no need.
A look in the Changelog didn't reveal anything important to me. After
those advisories, the situation has changed dramatically: systems
administrated by me were vulnerable to at least two DoS attacks.
As the fixed code has been released in June, those problems have to be
considered as known (at least to the bad guys). So those systems were
vulnerable to a known attack for months and  I could have avoided this
easily be upgrading to the latest kernel. I did not, because I did not
have the necessary information to make the right decision. I know that
I'm not the only one, who was caught by this, because people do not
upgrade the kernel of a production system, if they don't see the need
i.e. normally security issues.


The latest possible time for publishing an advisory, is when the fixed
code or patches are released. At this time, the issue *is* public and
admins depend on being "advised".
So my suggestion is, to release a security advisory with each new kernel
version, that summarizes the security issues, that are fixed with it.
The Changelogs as they are now do not provide sufficient information on
security issues.

This would also avoid situations like the problem with the netfilter
advisory: Harald Welte from the netfilter core team admitted, that they
had the advisory ready in April and scheduled its release for the release
of 2.4.21 final. The problem was: they just forgot to release it :-(

The way things are handled now is not only annoying administrators (I got
a couple of quite angry mails after my comment on this subject on
http://www.heise.de/security/artikel/39164 -- german only). It is
damaging the public image of the kernel and the people maintaining it.


I know, that some of you think, it's the task of the distributors, to
issue security advisories. I disagree: You publish code on kernel.org that
people use. That code contains security related bugs. You fix them and
publish corrected code. People expect from you, to issue an advisory
about the security bugs you have fixed - and imho they are right...

bye, ju

PS: Please CC any comments on this to me, because I do not subscribe to
this list.

-- 
Juergen Schmidt    Chefredakteur  heise Security   www.heisec.de
Heise Zeitschriften Verlag,  Helstorferstr. 7,  D-30625 Hannover
Tel. +49 511 5352 300 FAX +49 511 5352 417    EMail ju@heisec.de






