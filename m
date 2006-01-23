Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWAWFZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWAWFZN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 00:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWAWFZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 00:25:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54451 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964794AbWAWFZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 00:25:10 -0500
Subject: Re: -
	add-pselect-ppoll-system-call-implementation-tidy.patch	removed from -mm
	tree
From: David Woodhouse <dwmw2@infradead.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, axboe@suse.de, alan@lxorguk.ukuu.org.uk,
       sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
In-Reply-To: <43D0B4F5.30807@cosmosbay.com>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
	 <1137648119.30084.94.camel@localhost.localdomain>
	 <20060119171708.7f856b42.sfr@canb.auug.org.au>
	 <1137664692.8471.21.camel@localhost.localdomain>
	 <20060119155933.GX4213@suse.de>
	 <1137745995.30084.201.camel@localhost.localdomain>
	 <20060120004456.190f451b.akpm@osdl.org>
	 <1137747595.30084.215.camel@localhost.localdomain>
	 <43D0B4F5.30807@cosmosbay.com>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 18:25:10 +1300
Message-Id: <1137993911.27828.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 11:01 +0100, Eric Dumazet wrote:
> Some readers of linux kernel sources are blind.
> They use a kind of terminal that 'displays' a single line of 80 'characters' 
> (or even 40) called a 'Braille Display'
> 
> This kind of terminal is very expensive, and I think the 80 column one is the 
> most you can get (price : about 7000$).

Yes, I've seen them. What's your point? A user with a braille terminal
can also 'see' that it's just a memcpy of the signal set, and doesn't
really need to scroll over to see the length argument to the memcpy,
except in very exceptional circumstances. The code flow is perfectly
understandable without doing so.

> I am ok to be a litle bit upset by this 80 limitation that looks odd on my 
> 1000$ 24" display, but reminds me the fact that some human people are different.
> 
> So please don't count me as part of your _everyone_.

I count your theoretical blind person above as part of 'everyone'. By
gratuitously moving the 'fluff' onto a new line, he gets a whole line
taken up by it when he scrolls down. If it had stayed where I put it, it
wouldn't be getting in his way.

-- 
dwmw2

