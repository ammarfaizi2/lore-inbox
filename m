Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVDPPGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVDPPGa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 11:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVDPPGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 11:06:30 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:22979 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S261797AbVDPPG1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 11:06:27 -0400
Date: Sat, 16 Apr 2005 11:06:09 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: linux@horizon.com
Cc: daw@taverner.cs.berkeley.edu, tytso@mit.edu, linux-kernel@vger.kernel.org,
       mpm@selenic.com
Subject: Re: Fortuna
Message-ID: <20050416150609.GC17029@certainkey.com>
References: <20050416111033.28308.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050416111033.28308.qmail@science.horizon.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2005 at 11:10:33AM -0000, linux@horizon.com wrote:
> Thank you for pointing out the paper; Appendix A is particularly
> interesting.  And the [BST03] reference looks *really* nice!  I haven't
> finished it yet, but based on what I've read so far, I'd like to
> *strongly* recommnd that any would-be /dev/random hackers read it
> carefully.  It can be found at
> http://www.wisdom.weizmann.ac.il/~tromer/papers/rng.pdf
> 
> Happily, it *appears* to confirm the value of the LFSR-based input
> mixing function.  Although the suggested construction in section 4.1 is
> different, and I haven't seen if the proof can be extended.

Correct me if I'm wrong here, but uniformity of the linear function isn't
sufficant even if we implemented like this (right now it's more a+X than
a <dot> X).

The part which suggests choosing an irreducible poly and a value "a" in the
preprocessing stage ... last I checked the value for a and the poly need to
be secret.  How do you generate poly and a, Catch-22?  Perhaps I'm missing
something and someone can point it out.

JLC
