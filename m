Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbTAJQ1w>; Fri, 10 Jan 2003 11:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265378AbTAJQ1v>; Fri, 10 Jan 2003 11:27:51 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:30194
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265373AbTAJQ1q>; Fri, 10 Jan 2003 11:27:46 -0500
Date: Fri, 10 Jan 2003 11:37:10 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andi Kleen <ak@suse.de>, Hugh Dickins <hugh@veritas.com>,
       Daniel Ritz <daniel.ritz@gmx.ch>, "" <linux-kernel@vger.kernel.org>,
       "" <daniel.ritz@alcatel.ch>, Robert Love <rml@tech9.net>
Subject: Re: [PATCH 2.5] speedup kallsyms_lookup
In-Reply-To: <20030110161328.GV23814@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0301101135090.7163-100000@montezuma.mastecende.com>
References: <1042192419.1415.49.camel@cast2.alcatel.ch>
 <Pine.LNX.4.44.0301101428420.1292-100000@localhost.localdomain>
 <20030110160334.GU23814@holomorphy.com> <20030110161212.GA11193@wotan.suse.de>
 <20030110161328.GV23814@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, William Lee Irwin III wrote:

> At some point in the past, I wrote:
> >> So the end-result of the discussion is, "What should really happen here?"
> >> and "What, if anything, do you want me to do?"
>
> On Fri, Jan 10, 2003 at 05:12:12PM +0100, Andi Kleen wrote:
> > IMHO best would be to get rid of /proc/*/wchan and keep the kallsyms
> > lookup slow, simple and stupid.
>
> Slow, simple, and stupid == "wli, get the Hell out". I'm gone.

I don't really see a need for blazing fast lookup here, as long as it gets
done within a reasonable timeframe for common cases. Unless of course your
optimised version also saves space code wise.

	Zwane
-- 
function.linuxpower.ca
