Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264357AbTH1XAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 19:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264351AbTH1XAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 19:00:20 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:54919 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264357AbTH1XAR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 19:00:17 -0400
Date: Fri, 29 Aug 2003 00:00:10 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Message-ID: <20030828230010.GC10035@mail.jlokier.co.uk>
References: <MDEHLPKNGKAHNMBLJOLKEEEEFMAA.davids@webmaster.com> <E19sUzl-0004Az-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19sUzl-0004Az-00@calista.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> Why is that? For a hash with n bits there are at least
> 2^y / 2^n = 2^(y-n) files with the same hash, if they have size y bits.
> Three are even more, if you consider all files up to this size.

Correct.  Now, can you tell me how many of the 2^(y-n) files are ones
you will find on the net or on anybody's hard disk?

I'll take a couple of guesses: either 0 or 1 :)

The strength of a cryptographic hash is due to the immense difficulty
of deliberately creating a file given a hash value.  Another strength
is the very low probability of finding two different files with the
same hash value.

They're a bit like uncomputable numbers.  (Just a little bit).  Lots
of colliding files exist.  But if you can find even one pair, that's
an amazing event.

Uncomputable numbers are similar.  There are infinitely more
uncomputable numbers than computable ones, yet it is impossible to
write one down or even refer to a specific one of them.

-- Jamie
