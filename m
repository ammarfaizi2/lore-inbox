Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264955AbTGCKwF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 06:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbTGCKwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 06:52:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56068 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264955AbTGCKwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 06:52:03 -0400
Date: Thu, 3 Jul 2003 12:06:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Wiktor Wodecki <wodecki@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030703120626.D15013@flint.arm.linux.org.uk>
Mail-Followup-To: Wiktor Wodecki <wodecki@gmx.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20030703023714.55d13934.akpm@osdl.org> <20030703103703.GA4266@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030703103703.GA4266@gmx.de>; from wodecki@gmx.de on Thu, Jul 03, 2003 at 12:37:03PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 12:37:03PM +0200, Wiktor Wodecki wrote:
> On my thinkpad T20 it boots up fine, however when I insert my ne2000
> pcmcia card it instantly freezes. No Ooops or log message at all.
> 2.5.73-mm1 did fine.

Grr.

Can you try taking off each patch in reverse order at:

	http://patches.arm.linux.org.uk/pcmcia/pcmcia-event-20030623-*

and seeing which one caused your problem?

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

