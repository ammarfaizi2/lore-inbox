Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267759AbUHZHzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267759AbUHZHzs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 03:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267754AbUHZHzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 03:55:47 -0400
Received: from nysv.org ([213.157.66.145]:24714 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S267743AbUHZHzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 03:55:22 -0400
Date: Thu, 26 Aug 2004 10:53:48 +0300
To: Matt Mackall <mpm@selenic.com>
Cc: Nicholas Miell <nmiell@gmail.com>, Wichert Akkerman <wichert@wiggy.net>,
       Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
       Spam <spam@tnonline.net>, torvalds@osdl.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826075348.GT1284@nysv.org>
References: <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826053200.GU31237@waste.org>
User-Agent: Mutt/1.5.6i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 12:32:00AM -0500, Matt Mackall wrote:
>
>What it breaks is the concept of a file. In ways that are ill-defined,
>not portable, hard to work with, and needlessly complex. Along the
>way, it breaks every single application that ever thought it knew what
>a file was.

It breaks the concept of a file. In ways that offer more versatility,
challenge the imagination to make even better progress and keeps
Linux competing with competitors who are implementing this stuff
as we speak.

I for one would truly welcome the coming of thumbnails and descriptions
in picture files, because I have a real-life project going on where
that would be extremely handy to have in the actual file.
Were I any richer, I'd pay Namesys to have this work for me :)

>Find some silly person with an iBook and open a shell on OS X. Use cp
>to copy a file with a resource fork. Oh look, the Finder has no idea
>what the new file is, even though it looks exactly identical in the
>shell. Isn't that _wonderful_? Now try cat < a > b on a file with a
>fork. How is that ever going to work?

Then I guess OS X ships a broken implementation of cp, yes?

On the cat example, what if cat < a > b simply copies the "main stream"
and not the metadata, as a feature. The key being, "as a feature"

The metadata streams could get file descriptors of their own OR
another program, streamcat or something, could be written to compensate.

>I like cat < a > b. You can keep your progress.

With all due respect, I hope not too many people agree with you :)

-- 
mjt

