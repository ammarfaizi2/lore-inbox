Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265683AbTAJRLH>; Fri, 10 Jan 2003 12:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbTAJRLH>; Fri, 10 Jan 2003 12:11:07 -0500
Received: from ns.suse.de ([213.95.15.193]:57618 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265683AbTAJRLG>;
	Fri, 10 Jan 2003 12:11:06 -0500
Date: Fri, 10 Jan 2003 18:19:50 +0100
From: Andi Kleen <ak@suse.de>
To: Valdis.Kletnieks@vt.edu, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] speedup kallsyms_lookup
Message-ID: <20030110171950.GA6064@wotan.suse.de>
References: <1042192419.1415.49.camel@cast2.alcatel.ch> <Pine.LNX.4.44.0301101428420.1292-100000@localhost.localdomain> <20030110160334.GU23814@holomorphy.com> <20030110161212.GA11193@wotan.suse.de> <200301101713.h0AHDmLK010383@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301101713.h0AHDmLK010383@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 12:13:48PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 10 Jan 2003 17:12:12 +0100, Andi Kleen <ak@suse.de>  said:
> > 
> > > So the end-result of the discussion is, "What should really happen here?"
> > > and "What, if anything, do you want me to do?"
> > 
> > IMHO best would be to get rid of /proc/*/wchan and keep the kallsyms 
> > lookup slow, simple and stupid.
> 
> And replace the current /proc/*/wchan functionality with what?

Ctrl-Rollen (or whatever the key is called on your keyboard) on the console,
like in all previous linux releases.

Note /proc/*/wchan is not in 2.4.

Also you still have WCHAN in ps, just not a full backtrace.

-Andi
