Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTFTLvO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 07:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTFTLvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 07:51:14 -0400
Received: from [203.149.0.18] ([203.149.0.18]:17646 "EHLO
	krungthong.samart.co.th") by vger.kernel.org with ESMTP
	id S262955AbTFTLvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 07:51:13 -0400
Message-ID: <3EF2F872.7030604@thai.com>
Date: Fri, 20 Jun 2003 19:05:06 +0700
From: Samphan Raruenrom <samphan@thai.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Nuno Silva <nuno.silva@vgertech.com>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Crusoe's persistent translation on linux?
References: <Pine.LNX.4.44.0306191707000.1987-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0306191707000.1987-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Process startup is slightly slower due to the translation overhead, but
> that doesn't matter for the kernel anyway (so a native kernel wouldn't
> much help). And we do cache translations in memory, even across
> invocations. I suspect the reason large builds are slower are due to slow
> memory and/or occasionally overflowing the translation cache.

So how can I increase the size of the translation cache. I read from
Transmeta's whitepaper that both BIOS and OS can do this. This mean
that I should be able to insert a little piece of code in the kernel
somewhere and experiment with the new setting. I guess it might be a PCI
register?

How about the persistent translation service on Linux?
a) Transmeta will write it for us.
b) Transmeta will open enough info. for us to write it our own.
What do you think?

