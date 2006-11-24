Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757529AbWKXAs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757529AbWKXAs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 19:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757530AbWKXAs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 19:48:59 -0500
Received: from thunk.org ([69.25.196.29]:39311 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1757529AbWKXAs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 19:48:58 -0500
Date: Thu, 23 Nov 2006 19:48:55 -0500
From: Theodore Tso <tytso@mit.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>, linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
Message-ID: <20061124004855.GA10937@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
	linux-kernel@vger.kernel.org
References: <ek2nva$vgk$1@sea.gmane.org> <Pine.LNX.4.61.0611230107240.26845@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0611230107240.26845@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 01:10:08AM +0100, Jan Engelhardt wrote:
> Disk activities are "somewhat predictable", like network traffic, and 
> hence are not (or should not - have not checked it) contribute to the 
> pool. Note that urandom is the device which _always_ gives you data, and 
> when the pool is exhausted, returns pseudorandom data.

Plesae read the following article before making such assertions:

	D. Davis, R. Ihaka, P.R. Fenstermacher, "Cryptographic
	Randomness from Air Turbulence in Disk Drives", in Advances in
	Cryptology -- CRYPTO '94 Conference Proceedings, edited by Yvo
	G. Desmedt, pp.114--120. Lecture Notes in Computer Science
	#839. Heidelberg: Springer-Verlag, 1994.
	http://world.std.com/~dtd/random/forward.ps

Regards,

						- Ted

