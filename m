Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVDKQAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVDKQAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVDKQA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:00:29 -0400
Received: from [221.216.56.203] ([221.216.56.203]:27132 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S261823AbVDKP7W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 11:59:22 -0400
Date: Mon, 11 Apr 2005 23:46:38 +0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200504111546.j3BFkc330368@freya.yggdrasil.com>
To: torvalds@transmeta.com
Subject: Re: GIT license (Re: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.1)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-11, Linus Torvalds wrote:
>I'm inclined to go with GPLv2 just because it's the most common one [...]

	You may want to use a file from GPL'ed monotone that
implements a substantial diff optimization described in the August
1989 paper by Sun Wu, Udi Manber and Gene Myers ("An O(NP) Sequence
Comparison Algorithm").  According to th file, that implementation
was a port of some Scheme code written by Aubrey Jaffer to C++ by
Graydon Hoare.  (By the way, I would prefer that git just punt to
user level programs for diff and merge when all of the versions
involved are different or at least have a very thin interface
for extending the facility, because I would like to do some character
based merge stuff.)

	It looks to me like the anti-patent provisions of OSLv2.1
could be circumvented by an offender creating a separate company
to do patent litigation.  So, I think you'll find that the software
reuse benefits (both to GIT and to other software projects) of the
more widely used GPL ougtweigh the anti-patent benefits of OSLv2.1.

	Although I like the idea of anti-patent provisions, such
as those in OSLv2.1, I think mutual compatability of free
software is probably more consequential, even from a purely
political perspective.

	Perhaps you might want to consider offering the code
under the distributor's choice of either license if you want
to offer the very minor benefits of slightly easier compliance
to those who do not litigate software patents, or, perhaps more
importantly, the ability of the software to be copied into
OSLv2.1 projects (if there are any).

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
