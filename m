Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbVKBEtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbVKBEtV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 23:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbVKBEtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 23:49:21 -0500
Received: from dvhart.com ([64.146.134.43]:21418 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751495AbVKBEtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 23:49:20 -0500
Date: Tue, 01 Nov 2005 20:49:25 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Al Viro <viro@ftp.linux.org.uk>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Tony Luck <tony.luck@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New (now current development process)
Message-ID: <218950000.1130906965@[10.10.2.4]>
In-Reply-To: <20051031001810.GQ7992@ftp.linux.org.uk>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <p73r7a4t0s7.fsf@verdi.suse.de> <20051030213221.GA28020@thunk.org> <200510310145.43663.ak@suse.de> <20051031001810.GQ7992@ftp.linux.org.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Al Viro <viro@ftp.linux.org.uk> wrote (on Monday, October 31, 2005 00:18:10 +0000):

> On Mon, Oct 31, 2005 at 01:45:43AM +0100, Andi Kleen wrote:
>> The problem is that -mm* contains typically so many more or less
>> broken changes that any extensive work on there is futile 
>> because you never know whose bugs you're debugging
>> (and if the patch that is broken will even make it anywhere) 
>> 
>> In short mainline is frozen too long and -mm* is too unstable.
> 
> Besides, -mm is changing so fscking fast that it doesn't build on a lot
> of configs most of the time.  And trying to keep track of it and at least
> deal with build breakage at real time is, IME, hopeless.

To be fair, it's been a lot better the last month than it has the 2 before
that, when it was really pretty scary.

If it helps, we can try to build a wider range of configs to test. And I 
can try to hook Andrew up with something he can do a quick compile-farm 
test on before release (though I think he has his own battery of stuff).

M.

