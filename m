Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131445AbQKBMxz>; Thu, 2 Nov 2000 07:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131394AbQKBMxp>; Thu, 2 Nov 2000 07:53:45 -0500
Received: from ns.caldera.de ([212.34.180.1]:50437 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131505AbQKBMxg>;
	Thu, 2 Nov 2000 07:53:36 -0500
Date: Thu, 2 Nov 2000 13:52:18 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: torvalds@transmeta.com, linux-kbuild@torque.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] list-style makefile boilerplate without reordering
Message-ID: <20001102135218.A16541@caldera.de>
Mail-Followup-To: Peter Samuelson <peter@cadcamlab.org>,
	torvalds@transmeta.com, linux-kbuild@torque.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001101125837.A28861@caldera.de> <14848.12475.791640.17546@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <14848.12475.791640.17546@wire.cadcamlab.org>; from peter@cadcamlab.org on Wed, Nov 01, 2000 at 09:03:23AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 09:03:23AM -0600, Peter Samuelson wrote:
> 
> [Christoph Hellwig <hch@caldera.de>]
> > +
> > +# include a local makefile, if present
> > +-include Makefile.local
> 
> Why?

someone on lkml suggested it. It will not hurt but help some people.

>
> [all the other changes]
>

If have just rewritten Rules.make to not reorder objects and take input
in list-style format.  The big makefile rewrite should happen in 2.5, IMHO.

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
