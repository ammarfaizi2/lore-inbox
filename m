Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbTBCLBM>; Mon, 3 Feb 2003 06:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbTBCLBM>; Mon, 3 Feb 2003 06:01:12 -0500
Received: from [81.2.122.30] ([81.2.122.30]:29444 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265880AbTBCLBL>;
	Mon, 3 Feb 2003 06:01:11 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302031111.h13BBRRJ002363@darkstar.example.net>
Subject: Re: RFC: a code slush for 2.5?
To: jgarzik@pobox.com (Jeff Garzik)
Date: Mon, 3 Feb 2003 11:11:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E3E21D3.1090402@pobox.com> from "Jeff Garzik" at Feb 03, 2003 03:01:23 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My opinion of 2.5 could be summarized as, looking good, but still needs 
> some fleshing out.

Agreed.

> Linux 2.5 is a really exciting leap forward, in a lot a ways.

Definitely, the new input layer is particularly cool, in my opinion.
Plus, it's still usable on my 8Mb laptop, and usable, but impractical
on my 4Mb laptop.

> But at the same time, I _disagree_ with some kernel developers' 
> assertion that we need a code freeze, if that is strictly the "nothing 
> but bug fixes" definition.

I don't think a code freeze is appropriate yet, especially for small
additions, (auto-detection of more keyboards, and some kind of
blinking light output device, come to mind).

> I believe 2.5/2.6 would be better served by an addition period between 
> feature freeze and code freeze, where implementation and "fleshing out" 
> can take place.  Minor feature additions -- where required by existing 
> major features -- should be ok.

Agreed.

> Specific areas I think deserve attention before "nothing but bug fixes" 

I think we should separate areas in to, 'may have to justify patch !=
bug fix', and 'need a very good reason indeed why patch!=bug fix'.

> So, if I had to make the proposal concrete, I would propose:
> 	"code slush" effective immediately

Good idea.

> 	code freeze, Easter holiday (April 19?)

Might be too early for some areas.  I think we should have two code
freeze dates, and assign as much as possible to the earlier one, and
all the rest 6-8 weeks later, (or whatever it takes).

We need as close to 100% of developers as possible saying that
2.5.final is perfect before we make is 2.6.0.  Otherwise we are just
bumping the version number for the sake of it.

For example, modules have to be working 100%, (I don't mean everything
has to be compilable as a module, but rather that those that are need
to work), and this needs to have been tested for a couple of months,
in my opinon.  Also, we are still getting loads of reports of problems
with ACPI and APICs, and we need to specifically document that these
are completely different things, (we have had some ambiguous bug
reports in the past).

John.
