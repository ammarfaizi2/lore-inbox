Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272476AbTHFE4v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 00:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272495AbTHFE4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 00:56:51 -0400
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:4612
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S272476AbTHFE4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 00:56:47 -0400
Date: Tue, 5 Aug 2003 21:56:27 -0700
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5/2.6 PCMCIA Issues
Message-ID: <20030806045627.GA1625@nasledov.com>
References: <20030804232204.GA21763@nasledov.com> <20030805144453.A8914@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20030805144453.A8914@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 05, 2003 at 02:44:53PM +0100, Russell King wrote:
> Explain this further.  If you're saying that, when you removed the Orinoco
> card, that the eth interface remained (as shown by iwconfig and ifconfig)
> and the module use count didn't drop to zero, this isn't a PCMCIA problem.
> It's a problem somewhere in the hotplug / network scripts failing to take
> the interface down.

I don't believe the ethernet interface remained, but the module use
count definitely did not drop to zero. I suppose it's possible it's an
issue with the scripts, but the same scripts work perfectly under
2.4.21, which is what I primarily use on my laptop.

> What type of console?  Standard VT or under X11?

This was under the Linux framebuffer; inserting the card was the first
thing I did after it displayed the login prompt.

> The boot time kernel messages would be useful to see for 2.6.0-test2,
> including those issued by PCMCIA when the modules are loaded.

I am attaching the dmesg output after booting 2.6.0-test2; this does
not include the insertion of the Orinoco card as the console freezes
immediately after the event. I inspected my logs after a reboot and
there were no messages whatsoever regarding the event of the insertion
of the Orinoco card.
-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/

--xHFwDpU9dbj6ez1V
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="aurora-dmesg.gz"
Content-Transfer-Encoding: base64

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

--xHFwDpU9dbj6ez1V--
