Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVFWMeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVFWMeG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 08:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbVFWMeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 08:34:05 -0400
Received: from mx1.suse.de ([195.135.220.2]:3968 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262357AbVFWMdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 08:33:55 -0400
From: Andreas Schwab <schwab@suse.de>
To: linux-os@analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible spin-problem in nanosleep()
References: <Pine.LNX.4.61.0506230812160.15775@chaos.analogic.com>
X-Yow: Now I'm telling MISS PIGGY about MONEY MARKET FUNDS!
Date: Thu, 23 Jun 2005 14:33:52 +0200
In-Reply-To: <Pine.LNX.4.61.0506230812160.15775@chaos.analogic.com> (Richard
	B. Johnson's message of "Thu, 23 Jun 2005 08:18:05 -0400 (EDT)")
Message-ID: <jell516ymn.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <linux-os@analogic.com> writes:

> nanosleep() appears to have a problem. It may be just an
> 'accounting' problem, but it isn't pretty. Code that used
> to use usleep() to spend most of it's time sleeping, used
> little or no CPU time as shown by `top`. The same code,
> converted to nanosleep() appears to spend a lot of CPU
> cycles spinning. The result is that `top` or similar
> programs show lots of wasted CPU time.

usleep() is just a wrapper around nanosleep().  Are you sure you got the
units right?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
