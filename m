Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313599AbSDJTYX>; Wed, 10 Apr 2002 15:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313606AbSDJTYW>; Wed, 10 Apr 2002 15:24:22 -0400
Received: from ns.suse.de ([213.95.15.193]:2574 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313599AbSDJTYV>;
	Wed, 10 Apr 2002 15:24:21 -0400
To: Dominik Kubla <kubla@sciobyte.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: implementing soft-updates
In-Reply-To: <20020409184605.A13621@cecm.usp.br.suse.lists.linux.kernel> <200204100041.g3A0fSj00928@saturn.cs.uml.edu.suse.lists.linux.kernel> <20020410092807.GA4015@duron.intern.kubla.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 10 Apr 2002 21:24:20 +0200
Message-ID: <p73adsbpdaz.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Kubla <kubla@sciobyte.de> writes:

> The background  fsck capability, just  like journalling or  logging, are
> typically only in needed in 24/7 systems (sure, they are nice to have in
> your home  system, but do  you _REALLY_ need  them? i don't!)  and those
> system  typically are  run on  proven  hardware which  is operated  well
> within the specs. So please don't construct these kinds of arguments.

You can already do background fsck on a linux system today. Just do it on
a LVM/EVMS snapshot.


-Andi

