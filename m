Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287161AbSABXAy>; Wed, 2 Jan 2002 18:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287155AbSABXAf>; Wed, 2 Jan 2002 18:00:35 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:47100 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S287160AbSABXAX>; Wed, 2 Jan 2002 18:00:23 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200201022239.OAA21717@atrus.synopsys.com> 
In-Reply-To: <200201022239.OAA21717@atrus.synopsys.com> 
To: Joe Buck <jbuck@synopsys.COM>
Cc: VANDROVE@vc.cvut.cz (Petr Vandrovec), pkoning@equallogic.com (Paul Koning),
        trini@kernel.crashing.org, velco@fadata.bg,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Jan 2002 22:59:39 +0000
Message-ID: <23060.1010012379@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jbuck@synopsys.COM said:
> > An ICE, while it's not quite what was expected and it'll probably get
> > fixed, is nonetheless a perfectly valid implementation of 'undefined 
> > behaviour'.

>  Not for GCC it isn't.  Our standards say that a compiler crash, for
> any input whatsoever, no matter how invalid (even if you feed in line
> noise), is a bug.  Other than that we shouldn't make promises, though
> the old gcc1 behavior of trying to launch a game of rogue or hack when
> encountering a #pragma was cute.

True - sorry, I forgot where this was crossposted. I didn't mean to imply
that GCC folks would _accept_ an ICE and not fix it - just that strictly
speaking, it is a perfectly valid response, as is the unintended observed
behaviour of the output code which actually started this thread.

--
dwmw2


