Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTLDDpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 22:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTLDDpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 22:45:23 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:1036 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S262601AbTLDDpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 22:45:19 -0500
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1070509204@astro.swin.edu.au>
Subject: Re: Linux 2.4 future
References: <20031202135423.GB13388@conectiva.com.br> <Pine.LNX.4.58.0312021508470.21855@moje.vabo.cz> <bql9kk$iq1$1@gatekeeper.tmr.com> <20031204012420.GE4420@pegasys.ws> <20031204014743.GF29119@mis-mike-wstn.matchmail.com>
X-Face: m+g#A-,3D0}Ygy5KUD`Hckr=I9Au;w${NzE;Iz!6bOPqeX^]}KGt=l~r!8X|W~qv'`Ph4dZczj*obWD25|2+/a5.$#s23k"0$ekRhi,{cP,CUk=}qJ/I1acc
Message-ID: <slrn-0.9.7.4-10320-18132-200312041440-tc@hexane.ssi.swin.edu.au>
Date: Thu, 4 Dec 2003 14:45:13 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> said on Wed, 3 Dec 2003 17:47:43 -0800:
> On Wed, Dec 03, 2003 at 05:24:20PM -0800, jw schultz wrote:
> > 	xfs -- home (because of the jfs bug) Earlier tests
> > 	of xfs gave me horrible performance and i haven't
> > 	gotten around to testing since then.  If this is
> > 	fixed without tuning i might drop jfs.  Then again i
> > 	may drop xfs in the next upgrade if i change distros
> > 	and xfs isn't in-kernel.
> 
> What about ext3?  I tend to prefer ext3 since I know how it works more than
> the others, and it puts data integrity ahead of performance, which is the
> way things should be (TM).

Is it true that JFS still doesn't use a /lost+found?

The justification being that it doesn't want to stuff up the directory
structure anymore than it already supposedly is.

Personally, I think this behaviour is shit, because I would have to
reinstall from backup everytime I get an unclean shutdown (which
defeats the purpose of having journalling at all). (from memory, at
fsck time, it doesn't actually print out that many diagnostics, so I
don't know what adverse things have happened to my filesystem).

I have had plenty of problems with it. One I can think of is under
debian, after your $RANDOM mounts, it doesn't manage to do the
automatic forced fsck, so none of the filesystems get mounted. It
tries to stumble along without having mounted /usr. I have to reboot,
log in single user, and manually fsck. I don't know whther this is a
fsck.jfs or a debian deficiency.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Animals who are not penguins can only wish they were.
