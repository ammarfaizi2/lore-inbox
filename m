Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVJ3XrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVJ3XrQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 18:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVJ3XrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 18:47:16 -0500
Received: from cantor2.suse.de ([195.135.220.15]:40846 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751263AbVJ3XrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 18:47:16 -0500
From: Andi Kleen <ak@suse.de>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: New (now current development process)
Date: Mon, 31 Oct 2005 01:45:43 +0100
User-Agent: KMail/1.8
Cc: Linus Torvalds <torvalds@osdl.org>, Tony Luck <tony.luck@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <p73r7a4t0s7.fsf@verdi.suse.de> <20051030213221.GA28020@thunk.org>
In-Reply-To: <20051030213221.GA28020@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510310145.43663.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 October 2005 22:32, Theodore Ts'o wrote:

> I thought Andrew was accepting patches targeted at 2.6.n+1 into the
> -mm tree during the freeze periods, yes?  If so, why would it be a
> case of "nothing much happens"?  Nothing much might be happening in
> Linus's git tree, but that doesn't that they can't be happening in
> Andrew's -mm patchsets....

The problem is that -mm* contains typically so many more or less
broken changes that any extensive work on there is futile 
because you never know whose bugs you're debugging
(and if the patch that is broken will even make it anywhere) 

In short mainline is frozen too long and -mm* is too unstable.

-Andi
