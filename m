Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbTGCQXq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 12:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbTGCQVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 12:21:06 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:13840 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264881AbTGCQRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 12:17:30 -0400
Date: Thu, 3 Jul 2003 17:31:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
Message-ID: <20030703173155.A10665@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <UTC200307031625.h63GPx209151.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200307031625.h63GPx209151.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Thu, Jul 03, 2003 at 06:25:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 06:25:59PM +0200, Andries.Brouwer@cwi.nl wrote:
> They are used much more frequently than cryptoapi is.
> People tell me jari-loop is much faster at present.
> If this is true, your move would not be very popular.

Personally I care far less about one cryptoloop implementation
beeing faster than another one, but about proper design of whatever
gets into mainline. Think about this like the freeswan vs kernel
ipsec thing - of course klips had more feature and more mature code
initially (and maybe still has in some areas) but the kernel ipsec
is the much better design.

I'd be very interested in seeing some backing and explanation of his
claims so we can incorporate it into the generic cryptoapi / loop code.

The only thing I could imagine is that he has assembly implementations
of many ciphers that are faster than the C ones in cryptoapi - something
that's on the cryptoapi todo list anyway.

> Anyway, I am not doing a redesign. Just a cleanup.

Umm, no.  You add a feature.  That's something very different from
a cleanup.

