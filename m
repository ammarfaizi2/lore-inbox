Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318602AbSHLC04>; Sun, 11 Aug 2002 22:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318607AbSHLC04>; Sun, 11 Aug 2002 22:26:56 -0400
Received: from waste.org ([209.173.204.2]:11431 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318602AbSHLC0z>;
	Sun, 11 Aug 2002 22:26:55 -0400
Date: Sun, 11 Aug 2002 21:29:54 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alexander Viro <viro@math.psu.edu>
cc: Rob Landley <landley@trommello.org>, "H. Peter Anvin" <hpa@zytor.com>,
       "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: klibc development release
In-Reply-To: <Pine.GSO.4.21.0208110900440.13360-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0208112119540.25011-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Aug 2002, Alexander Viro wrote:

> > What's wrong with LGPL?  I thought libraries were what it was originally
>
> klibc is static-only.  So for all practical purposes LGPL would be every bit
> as viral as GPV itself.

You say that as if it were a bad thing.

(And technically incorrect, if you also provide .o files so that the end
user can relink as they desire.)

That aside for the moment, isn't the plan to pull stuff that's currently
GPL out of the kernel and link against this lib anyway?

Second point - if it goes into the kernel source tree as suggested, but
with a 'copycenter' license, we can expect to have the nVidia problem but
worse.

Making it GPL shouldn't be a big deal. It is intended to be a small amount
of code, after all. And I'd hate to get into a situation where people
started shipping their magic 'make the hardware work' bits as closed
replacements for the early boot code.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

