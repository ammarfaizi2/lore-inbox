Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTGGAh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 20:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTGGAh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 20:37:57 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:40157 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263638AbTGGAh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 20:37:56 -0400
Date: Mon, 7 Jul 2003 02:54:49 +0200
From: Vincent Touquet <vincent.touquet@pandora.be>
To: linux-kernel@vger.kernel.org
Subject: Re: [Bug report] System lockups on Tyan S2469 and lots of io [smp boot time problems too :(]
Message-ID: <20030707005449.GF4675@ns.mine.dnsalias.org>
Reply-To: vincent.touquet@pandora.be
References: <20030706210243.GA25645@lea.ulyssis.org> <20030707003007.GE4675@ns.mine.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030707003007.GE4675@ns.mine.dnsalias.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 07, 2003 at 02:30:07AM +0200, Vincent Touquet wrote:
>PS: will test if the system still locks up soon, I hope not...

So it does lock up again :(((

But now I was able to quickly switch to console and grab the contents of
/var/log/messages before it totally hanged. I can usually tell when the
hang is going to happen: activity on the array stops, then I have a few
more seconds till it hangs completely ....

The message was:

Jul 7 02:45:36 kalimero kernel: 3w-xxxx: scsi0: Unit #0:
command (f7618800) timed out, resetting card.

Then of course, the system totally hangs.

The same problem occurred to me on a Tyan S2468, with a different 3Ware
card. This has to be a kernel problem ... (or BIOS problem, if the S2468
and 2469 BIOSs are sufficiently similar ?).

thanks for any help,

Vincent
