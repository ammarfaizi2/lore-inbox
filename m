Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbUL2TeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbUL2TeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 14:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbUL2TeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 14:34:14 -0500
Received: from [195.23.16.24] ([195.23.16.24]:29831 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261401AbUL2TeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 14:34:09 -0500
Message-ID: <41D306AF.1020500@grupopie.com>
Date: Wed, 29 Dec 2004 19:34:07 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Park <opengeometry@yahoo.ca>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       Andreas Unterkircher <unki@netshadow.at>
Subject: Re: waiting 10s before mounting root filesystem?
References: <20041227195645.GA2282@node1.opengeometry.net> <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at> <20041229005922.GA2520@node1.opengeometry.net> <Pine.LNX.4.61.0412290231580.3528@dragon.hygekrogen.localhost> <20041229015622.GA2817@node1.opengeometry.net> <41D2A7BE.2030806@grupopie.com> <20041229191525.GA2597@node1.opengeometry.net>
In-Reply-To: <20041229191525.GA2597@node1.opengeometry.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.29.0.5; VDF: 6.29.0.39; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Park wrote:
> [...]
> I read Documentation/initrd.txt and I don't understand it.  If I
> understand it right, I have to build a complete root filesystem with all
> the stuffs necessary for mounting the second (real) root filesystem.  If
> I'm loading the kernel from floppy, then I only have 200k to work with.
> I'll try initrd.txt, step by step over the holidays.

Yes, but if you use "nash" as a script parser and compile everything you 
need static with dietlibc or uClibc (or some other small libc 
replacement), 200k will be plenty to accomplish what you want. You'll 
probably be able to find pre-compiled binaries like these on the net, if 
you search for them.

Of course this is much more work than simply patch the kernel to wait a 
little, but with this training you'll be able to handle similar 
situations in the future were there is no patch to solve them.

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu
