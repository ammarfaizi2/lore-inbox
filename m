Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUHGFui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUHGFui (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 01:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUHGFui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 01:50:38 -0400
Received: from holomorphy.com ([207.189.100.168]:20178 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266258AbUHGFuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 01:50:37 -0400
Date: Fri, 6 Aug 2004 22:50:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Shoemaker <c.shoemaker@cox.net>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, vda@port.imtp.ilyichevsk.odessa.ua,
       ak@suse.de
Subject: Re: Possible dcache BUG
Message-ID: <20040807055031.GW17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Chris Shoemaker <c.shoemaker@cox.net>,
	Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	vda@port.imtp.ilyichevsk.odessa.ua, ak@suse.de
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408060751.07605.gene.heskett@verizon.net> <Pine.LNX.4.58.0408060948310.24588@ppc970.osdl.org> <200408061316.24495.gene.heskett@verizon.net> <20040806172607.GO17188@holomorphy.com> <20040806231902.GB15493@cox.net> <20040807041550.GV17188@holomorphy.com> <20040807000521.GA15636@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040807000521.GA15636@cox.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 09:15:50PM -0700, William Lee Irwin III wrote:
>> I've not seen this ever again after some point, and don't recall enough
>> of the context/etc. to say much about what was going on with it.

On Fri, Aug 06, 2004 at 08:05:21PM -0400, Chris Shoemaker wrote:
> I know what you mean.  Sometimes I don't know which bothers me more, the
> oopses that inexplicably DON'T come back, or the ones that DO.
> Perchance, have you added RAM since the oops, or changed the machine's
> memory-related behavior?

Neither. Only the kernel has changed. Upon closer inspection, local
changes with direct impact on the inode cache are likely suspects.


-- wli
