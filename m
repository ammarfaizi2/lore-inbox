Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270621AbTHORrW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270624AbTHORrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:47:22 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:32389 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S270621AbTHORrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:47:19 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: Clock <clock@twibright.com>
Subject: Re: nforce2 lockups
Date: Fri, 15 Aug 2003 18:47:20 +0100
User-Agent: KMail/1.5.9
References: <df962fdf9006.df9006df962f@us.army.mil> <200308151738.08965.alistair@devzero.co.uk> <20030815210601.A5452@beton.cybernet.src>
In-Reply-To: <20030815210601.A5452@beton.cybernet.src>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308151847.20128.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 August 2003 20:06, Clock wrote:
[SNIP]
>
> I have had three boards with nforce2 replaced (all of them Soltek
> SL75FRN2-L) and all three did the same. However it seemed the frequency of
> the crashes varies with actual piece of board.

That's certainly interesting.

>
> The crashes aren't in software - bare 'cat /dev/hda > /dev/null' is
> often to lock up the machine to the point that poweroff fails.

[root] 06:43 PM [/home/alistair] time cat /dev/discs/disc0/disc > /dev/null
(I ctrl-C'd here)

real    1m23.275s
user    0m0.979s
sys     0m12.608s

I don't know how obvious the problem is on your machine, but it's clearly not 
an issue on this nForce2. When I was referring to software, that included the 
kernel i.e., I suspect it isn't a design fault.

Any other details?

Cheers,
Alistair.
