Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVATC0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVATC0q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 21:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVATC0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 21:26:46 -0500
Received: from epithumia.math.uh.edu ([129.7.128.2]:3722 "EHLO
	epithumia.math.uh.edu") by vger.kernel.org with ESMTP
	id S261961AbVATCYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 21:24:37 -0500
To: Peter Daum <gator@cs.tu-berlin.de>
Cc: <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
       Adam Radford <aradford@amcc.com>
Subject: Re: 3ware driver (3w-xxxx) in 2.6.10: procfs entry
References: <Pine.LNX.4.30.0501191309500.20626-100000@swamp.bayern.net>
From: Jason L Tibbitts III <tibbs@math.uh.edu>
Date: Wed, 19 Jan 2005 20:23:52 -0600
In-Reply-To: <Pine.LNX.4.30.0501191309500.20626-100000@swamp.bayern.net> (Peter
 Daum's message of "Wed, 19 Jan 2005 13:33:15 +0100 (MET)")
Message-ID: <ufad5w07s93.fsf@epithumia.math.uh.edu>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "PD" == Peter Daum <gator@cs.tu-berlin.de> writes:

PD> At least on my 8506-controllers there are also some minor problems
PD> (e.g. "info" doesn't work during a verify) which I thought was due
PD> to the fact that the program is intended exclusively for
PD> 9000-controllers.

You should report the problems you find to them.  They do indicate (in
the knowledge base on their web site) that you're going to need the
in-engineering files to run on the latest kernels.  It's only recently
that the newer tools acquired the ability to control older
controllers.

According to a recent post from a 3ware employee on linux-ide-arrays,
a proper release is expected in February.  Obviously the best solution
is that they just give us the source to these tools so that we can fix
them ourselves.  Knowing that isn't going to happen I'm happy they're
at least giving us something while they catch up with the speed of
kernel progress.

I can verify the fact that info is busted when the controller is
verifying the array; I'll gather some more info and pass this on to
3ware.

 - J<
