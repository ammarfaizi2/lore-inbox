Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269344AbUIYOv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269344AbUIYOv4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 10:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269345AbUIYOv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 10:51:56 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:48573 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S269344AbUIYOvx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 10:51:53 -0400
Date: Sat, 25 Sep 2004 10:51:08 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040925145108.GV28317@certainkey.com>
References: <20040923234340.GF28317@certainkey.com> <20040924043851.GA3611@thunk.org> <20040924125457.GO28317@certainkey.com> <20040924174301.GB20320@thunk.org> <20040924175929.GU28317@certainkey.com> <20040924213452.GA22399@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924213452.GA22399@thunk.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 05:34:52PM -0400, Theodore Ts'o wrote:
> > Woh there.  Didn't you just say "see, these hashes are weakened.  That's
> > bad".  Now I just demonstrated the same thing with your SHA1 implementation
> > and you throw that "red-herring" phrase out again?
> 
> No, what I'm saying is that crypto primitives can get weakened; this
> is a fact of life.  SHA-0, MD4, MD5, etc. are now useless as general
> purpose cryptographic hashes.  Fortuna makes the assumptions that
> crypto primitives will never break, as it relies on them so heavily.
> I have a problem with this, since I remember ten years ago when people
> were as confident in MD5 as you appear to be in SHA-256 today.

http://eprint.iacr.org/2004/207.pdf

SHA-256 showing indications of weakness.  Fortuna's algorithms can be
replaced at compile-time.  I may even consider doing them at run-time.

> Crypto academics are fond of talking about how you can "prove" that
> Fortuna is secure.  But that proof handwaves around the fact that we
> have no capability of proving whether SHA-1, or SHA-256, is truly
> secure.

Our issues are that we are *both* handwaving.

JLC
