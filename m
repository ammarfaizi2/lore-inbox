Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266246AbUHGFp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266246AbUHGFp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 01:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUHGFp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 01:45:59 -0400
Received: from lakermmtao04.cox.net ([68.230.240.35]:14281 "EHLO
	lakermmtao04.cox.net") by vger.kernel.org with ESMTP
	id S266246AbUHGFp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 01:45:57 -0400
Date: Fri, 6 Aug 2004 20:05:21 -0400
From: Chris Shoemaker <c.shoemaker@cox.net>
To: William Lee Irwin III <wli@holomorphy.com>,
       Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, vda@port.imtp.ilyichevsk.odessa.ua,
       ak@suse.de
Subject: Re: Possible dcache BUG
Message-ID: <20040807000521.GA15636@cox.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408060751.07605.gene.heskett@verizon.net> <Pine.LNX.4.58.0408060948310.24588@ppc970.osdl.org> <200408061316.24495.gene.heskett@verizon.net> <20040806172607.GO17188@holomorphy.com> <20040806231902.GB15493@cox.net> <20040807041550.GV17188@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040807041550.GV17188@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 09:15:50PM -0700, William Lee Irwin III wrote:
> On Fri, Aug 06, 2004 at 10:26:07AM -0700, William Lee Irwin III wrote:
> >> I've not had issues around the dcache for quite some time, I think not
> >> since the 2.5.65 timeframe. IIRC maneesh and dipankar had some fixes
> >> that resolved all my issues not long afterward. So unfortunately I have
> >> nothing strictly dcache-related to report. Chris may have been
> >> referring to some potentially pathological NFS behavior I've seen for a
> >> long time centered around extended periods of knfsd unresponsiveness.
> 
> On Fri, Aug 06, 2004 at 07:19:02PM -0400, Chris Shoemaker wrote:
> > I was referring to:
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0406.2/0410.html
> > ...doesn't look NFS-related to me.  OTOH, it does bear some resemblance
> > to some other oopses floating around.  Did you solve this one?
> 
> I've not seen this ever again after some point, and don't recall enough
> of the context/etc. to say much about what was going on with it.
> 
> -- wli

I know what you mean.  Sometimes I don't know which bothers me more, the
oopses that inexplicably DON'T come back, or the ones that DO.

Perchance, have you added RAM since the oops, or changed the machine's
memory-related behavior?

-chris



