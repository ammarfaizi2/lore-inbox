Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267949AbTBYMJL>; Tue, 25 Feb 2003 07:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267950AbTBYMJL>; Tue, 25 Feb 2003 07:09:11 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:10641 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S267949AbTBYMJK>; Tue, 25 Feb 2003 07:09:10 -0500
Date: Tue, 25 Feb 2003 12:25:08 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andreas Schwab <schwab@suse.de>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
Message-ID: <20030225122508.GB17690@bjl1.jlokier.co.uk>
References: <jeu1et5o4i.fsf@sykes.suse.de> <Pine.LNX.4.44.0302241429150.13406-100000@penguin.transmeta.com> <20030225052436.GB18302@f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225052436.GB18302@f00f.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Mon, Feb 24, 2003 at 02:39:36PM -0800, Linus Torvalds wrote:
> 
> > Claiming that you should index an array with a size_t is crap.
> 
> it's broken in general; there is *lots* of code which does things like
> "foo[-1] = bar" (string parsers for example)

Yeah, the index should be ptrdiff_t :)

-- Jamie
