Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271362AbTHDC31 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 22:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271363AbTHDC31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 22:29:27 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:20364
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271362AbTHDC30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 22:29:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Voluspa <lista1@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O12.2int for interactivity
Date: Mon, 4 Aug 2003 12:34:31 +1000
User-Agent: KMail/1.5.3
References: <20030803231949.3ca947f6.lista1@telia.com>
In-Reply-To: <20030803231949.3ca947f6.lista1@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308041234.31410.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 07:19, Voluspa wrote:
> I can hardly spot any difference between 2.6.0-test2, A3 and A3-O12.2
> while running the test as outlined in:

Thanks for testing. The difference should only be noticable as X and other 
interactive tasks remaining responsive under heavy load. Audio skips are far 
less relevant any more.

> numbers. Just one oddity - and now I'm uncertain of its validity - as
> can be seen on the screencaps below. In A3 wine had a PRI of 25,
> wineserver had 15. In A3-O12.2 the numbers were reversed. I can redo the
> test if necessary.

No this is what I need to understand what went wrong. These hacks work on 
changing the value of PRI basically. The wine/wineserver issue is an unusual 
one as you've described it, and at O11 the test I put in to determine a task 
is interactive by credits seems to select out the wrong one and keep that one 
elevated. 

Anyway most of this discussion is now moot as I've discussed with Ingo at 
length a lot of the little things I've found that help and I suspect he will 
develop his own, better solutions for them.

Con 

