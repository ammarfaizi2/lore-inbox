Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTEMP6E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbTEMP54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:57:56 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:12254 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id S261864AbTEMP5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:57:24 -0400
Date: Tue, 13 May 2003 17:10:02 +0100
From: Ian Molton <spyro@f2s.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: ARM26 [NEW ARCHITECTURE]
Message-Id: <20030513171002.741f080b.spyro@f2s.com>
In-Reply-To: <20030513170029.B15172@flint.arm.linux.org.uk>
References: <20030513153315.73679a38.spyro@f2s.com>
	<1052835818.431.37.camel@dhcp22.swansea.linux.org.uk>
	<20030513170029.B15172@flint.arm.linux.org.uk>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003 17:00:29 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

> The basic idea is to rip out the arm26 code from arch/arm and
> include/asm-arm, thereby allowing include/asm-arm/proc-armv to
> be collapsed into include/asm-arm, removing some clutter.

Yep.

speaking of which - let me know when you want the next round of patches
to remove the ARM26 stuff from arch/arm please ;-)

> Separating it out should also allow arm26 to shrink down to
> something smaller, which is fairly critical for these machines.

Yep. the [compiled size of the] kernel has already begun to decrease,
and its looking quite promising (If I ever get the time to finish it!)

I just want to get it 'out there' so the couple of other folks
interested can start hacking on it too.

I have an ide driver too, if anyone wants to submit it for the
mainstream kernel. It drives SIMTEC IDE cards, found in Acorn machines,
and is, of course, non-invasive to the tree. Its for 2.4. I'd imagine
Russell would be happy to let someone else take it off his hands?
(Russell?)

-- 
Spyros lair: http://www.mnementh.co.uk/
Do not meddle in the affairs of Dragons, for you are tasty and good with
ketchup.

Systems programmers keep it up longer.
