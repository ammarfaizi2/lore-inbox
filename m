Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbTCKSqG>; Tue, 11 Mar 2003 13:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbTCKSqG>; Tue, 11 Mar 2003 13:46:06 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:8632 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261509AbTCKSqG>;
	Tue, 11 Mar 2003 13:46:06 -0500
Date: Tue, 11 Mar 2003 10:46:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Zack Brown <zbrown@tumblerings.org>, Daniel Phillips <phillips@arcor.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <22230000.1047408397@flay>
In-Reply-To: <20030311184043.GA24925@renegade>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030309000514.GB1807@work.bitmover.com> <20030309024522.GA25121@renegade> <20030309225857.0FAC7101207@mx12.arcor-online.net> <20030311184043.GA24925@renegade>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've taken a lot of stuff from that wish list, combined it with what I gathered
> from Larry's earlier post, and from Petr Baudis' recent post, and elsewhere,
> and organized it into something that might be interesting. If anyone would
> like to host this document on the web, please let me know.

Not sure if this was captured before (I don't see it explicitly in what
you sent), but one thing that I don't think current tools do well is to
keep changes seperated out. We need to be able to put a stack of 200
patches on top of 2.5.10, then be able to break those out again easily
come 2.5.60, once we've merged forward. Treating things as one big blob
will work great for Linus, but badly for others.

At the moment, I slap the patches back on top of every new version 
seperately, which works well, but is a PITA. I hear this is something
of a pain to do with Bitkeeper (don't know, I've never tried it). 
People muttered things about keeping 200 different views, which is
fine for hardlinked diff & patch (takes < 1s to clone normally), but
I'm not sure how long a merge would take in Bitkeeper this way? Perhaps
people who've done this in other SCM's could comment?

M.

