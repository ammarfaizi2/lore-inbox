Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSHBQBp>; Fri, 2 Aug 2002 12:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSHBQB0>; Fri, 2 Aug 2002 12:01:26 -0400
Received: from ns.suse.de ([213.95.15.193]:24581 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316585AbSHBQAo>;
	Fri, 2 Aug 2002 12:00:44 -0400
Date: Fri, 2 Aug 2002 18:04:14 +0200
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: adjust prefetch in free_one_pgd()
Message-ID: <20020802180414.Q25761@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>, davidm@hpl.hp.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	davidm@napali.hpl.hp.com
References: <20020802175608.O25761@suse.de> <Pine.LNX.4.44.0208020859060.18265-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0208020859060.18265-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Aug 02, 2002 at 08:59:35AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 08:59:35AM -0700, Linus Torvalds wrote:

 > >  > Personally, I would just say that we should disable prefetch on such
 > >  > clearly broken hardware, but since it's Alans favourite machine (some
 > >  > early AMD Athlon if I remember correctly), I think Alan will disagree ;)
 > > I think I now understand why you silently dropped the 'disable broken hw
 > > prefetch on early stepping P4' patch I sent you. 8-)
 > 
 > No, I don't think either I (nor Alan) has any early stepping P4's.
 > Me dropping patches is just normal ;)

Hmm, it was in the patch including Patricks cpu/ reorganisation,
so it seems you applied it, and then hacked it out 8-)

*shines spotlight on Linus*

Oh well, I'll retransmit sometime. I've been really lax about pushing
stuff to you of late anyway, so a big push when I come back from
my vacation would be a good thing.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
