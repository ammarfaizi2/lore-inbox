Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267773AbTGOOVs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 10:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbTGOOVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 10:21:48 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:8875 "EHLO fed1mtao01.cox.net")
	by vger.kernel.org with ESMTP id S267773AbTGOOVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 10:21:00 -0400
Date: Tue, 15 Jul 2003 07:35:50 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: simon@baydel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC 440 System
Message-ID: <20030715073549.B6208@home.com>
Reply-To: linuxppc-embedded@lists.linuxppc.org
References: <3F12A1B9.3086.614B56@localhost> <524r1pw0bd.fsf@topspin.com> <3F13D64D.12715.E1BA3@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F13D64D.12715.E1BA3@localhost>; from simon@baydel.com on Tue, Jul 15, 2003 at 10:24:13AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should have been on linuxppc-embedded.

On Tue, Jul 15, 2003 at 10:24:13AM +0100, simon@baydel.com wrote:
> I don't understand. Can I not just use the math emulation in the kernel ?

Yes you can. However, most developers on PPC4xx are interested in
eventual deployment.  Kernel math emulation is slow relative to
a soft float enabled userland so using something like ELDK or MVL
with PPC4xx/8xx makes a lot more sense.  If you want to leverage
binaries from Yellowdog/Debian/foo that are compiled for a classic
PPC processor rather than natively then you'll need to enable math
emulation.

Regards,
-- 
Matt Porter
mporter@kernel.crashing.org
