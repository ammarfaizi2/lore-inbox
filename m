Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269250AbUHZRTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269250AbUHZRTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269249AbUHZRTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:19:40 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:55769 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S269258AbUHZRRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:17:50 -0400
Date: Thu, 26 Aug 2004 19:15:40 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: Jay Lan <jlan@engr.sgi.com>, lkml <linux-kernel@vger.kernel.org>,
       erikj@dbear.engr.sgi.com, limin@engr.sgi.com,
       lse-tech@lists.sourceforge.net,
       =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>,
       Arthur Corliss <corliss@digitalmages.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [PATCH] new CSA patchset for 2.6.8
In-Reply-To: <20040825221842.72dd83a4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de>
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004, Andrew Morton wrote:

> More broadly: Help!
> 
> I am 100% not in a position to judge whether Linux needs Comprehensive
> System Accounting, nor am I able to define what the requirements for such a
> thing should be.  All I can tell from your patch is the quality of its
> implementation, and that's leaping far, far ahead of where we should be.
> 
> We're going to need help from you, and from all the other stakeholders in
> judging how useful this feature is to Linux implementors and how well this
> implementation meets the (unknown) requirements.  See my problem?
> 
> I've cc'ed lse-tech, where enterprise folks hang out.  I would request that
> the people who are stakeholders in this feature
> 
> a) stick their hands up
> 
> b) let us know how important this kind of feature is for their users
> 
> c) review the offered feature set against their requirements
> 
> d) let us know how well the implementation fits that requirement and
> 
> e) inform us of any competing implementations.  Compare and contrast.

Judging from the feedback during it's stay in -mm (none at all!), general
interest in BSD accounting seems quite limited. The rate of downloads of
the updated userspace tools is hardly distinguishable from background
noise. (This might change with the correct URL in the help text now, but
even that was broken for months and nobody cared).
Also general interest in the user space tools is low, the latest release 
of the GNU acct package is from 1998 (and yes, there _are_ problems 
warranting updates).

Funnily enough, with three competing implementation even interest from
developers seems larger than that from users (This statement includes me,
I did a patch but am not a user of it).) But communication between
developers is poor. I for myself only recently learned about ELSA and CSA.

Therefore I've Cc:ed some people from whom I got valuable feedback on the
BSD accounting format patch.

IMHO CSA, ELSA and BSD accounting are too similar to have more than one of 
them in the kernel. We should either improve BSD accounting to do the job, 
or kill it in favor of a different implementation.

Tim
