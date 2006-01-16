Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWAPIxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWAPIxc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 03:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWAPIxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 03:53:32 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:27831 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1751071AbWAPIxb
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 03:53:31 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Jack Steiner <steiner@sgi.com>
Subject: Re: [patch] mm: cleanup bootmem
References: <43C8F198.3010609@yahoo.com.au>
	<Pine.LNX.4.64.0601140949460.13339@g5.osdl.org>
	<43C93CCA.9080503@yahoo.com.au> <43C93DA0.3040506@yahoo.com.au>
	<Pine.LNX.4.64.0601141011300.13339@g5.osdl.org>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 16 Jan 2006 03:53:08 -0500
In-Reply-To: <Pine.LNX.4.64.0601141011300.13339@g5.osdl.org>
Message-ID: <yq0slrotuyz.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

Linus> On Sun, 15 Jan 2006, Nick Piggin wrote:
>> That's still completely functional after my patch. In fact, as I
>> said in a followup it is likely to work better than with David's
>> change to free batched pages as order-0, because I reverted back to
>> freeing them as higher order pages.

Linus> Ok. Then I doubt anybody will complain. I'm still wondering if
Linus> some of the other ugliness was due to some simulator
Linus> strangeness issues, but maybe even ia64 doesn't care that much
Linus> any more..

We still use simulators for a bunch of stuff, but I don't know if this
is affecting it or not. Jack Steiner may know more.

Cheers,
Jes
