Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbTANQC0>; Tue, 14 Jan 2003 11:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264686AbTANQCZ>; Tue, 14 Jan 2003 11:02:25 -0500
Received: from [195.223.140.107] ([195.223.140.107]:7300 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264673AbTANQCY>;
	Tue, 14 Jan 2003 11:02:24 -0500
Date: Tue, 14 Jan 2003 17:12:18 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre2aa2
Message-ID: <20030114161218.GD19700@dualathlon.random>
References: <20021226102814.GB6938@dualathlon.random> <20030114122334.GE919@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030114122334.GE919@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 04:23:34AM -0800, William Lee Irwin III wrote:
> On Thu, Dec 26, 2002 at 11:28:14AM +0100, Andrea Arcangeli wrote:
> > I'm leaving for vacations in 5 minutes so hopefully this will compile
> > for everybody ;) [I know, mylex still doesn't compile without backing
> > out the elevator-lowlatency patch but I hadn't time to fix it yet], I'll
> > be back online on 3 Jan.
> 
> Hmm. Where is init_one_highpage() defined?

I assumed it got dropped while upgrading to new mainline trees, Marcelo
merged parts of the arch init cleanup and probably init_one_highpage was
missing from those patches merged in mainline despite most other things
were present. Thanks for the info (I will now go find where it was lost).

Andrea
