Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289342AbSA2Jzf>; Tue, 29 Jan 2002 04:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289330AbSA2JzZ>; Tue, 29 Jan 2002 04:55:25 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:34055 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289328AbSA2JzJ>; Tue, 29 Jan 2002 04:55:09 -0500
Date: Tue, 29 Jan 2002 10:55:04 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020129095504.GC5485@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Rob Landley wrote:

> The holder of the patch penguin would feed Linus good patches, by Linus's 
> standards. Not just tested ones, but small bite-sized patches, one per email 
> as plain text includes, with an explanation of what each patch does at the 
> top of the mail. (Just the way Linus likes them. :) Current pending patches 
> from the patch penguin tree could even be kept at a public place (like 
> kernel.org) so Linus could pull rather than push, and grab them when he has 
> time. The patch penguin tree would make sure that when Linus is ready for a 
> patch, the patch is ready for Linus.

Looks like a manual re-implementation of a bug/request/patch tracker
like sourceforge's, bugzilla or whatever, with some additions. A patch
is added to the system, it gets a version tag, and you just pull it, and
mark it closed if applied to Linus' tree. If Linus releases a new tree,
the patch is marked stale until the maintainer uploads an updated patch
or just reopens it to mark "still applies unchanged to new version". (No
CVS involved, BTW.)

> One reason Linus doesn't like CVS is he won't let other people check code 
> into his tree. (This is not a capricious decision on Linus's part: no 
> architect can function if he doesn't know what's in the system. Code review 
> of EVERYTHING is a vital part of Linus's job.) With a patch penguin tree, 

That's one of the arguments Peter Miller uses to endorse his "Aegis"
system: separate the integration part. FreeBSD also seem to follow a
similar idea: there are maintainers and committers. Maintainers usually
do not commit, but file PRs tagged as "maintainer-update".

(Note: I've never used aegis myself, it seems as though it had some
implications with development spread to various locations, someone
comment on that.)

Also, I'm not sure how good Bitkeeper fits here, or whether subversion
will help in this way (one might consider feeding suggestions to the
subversion team, http://subversion.tigris.org/, if they do atomic
commits, one might consider holding them off until blessed by an
integrator).

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
