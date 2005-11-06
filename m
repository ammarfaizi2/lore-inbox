Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVKFV5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVKFV5U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 16:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbVKFV5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 16:57:19 -0500
Received: from ns2.suse.de ([195.135.220.15]:10468 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932265AbVKFV5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 16:57:17 -0500
From: Andreas Schwab <schwab@suse.de>
To: <grfgguvf@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Whys and hows of initrds
References: <8413367b0511060924s550024b8w1113564cd6bb9340@mail.gmail.com>
	<436E4FDF.7000503@mnsu.edu>
	<8413367b0511061256u565de887jf5819ff9b3b4030c@mail.gmail.com>
X-Yow: My BIOLOGICAL ALARM CLOCK just went off..  It has noiseless
 DOZE FUNCTION and full kitchen!!
Date: Sun, 06 Nov 2005 22:57:15 +0100
In-Reply-To: <8413367b0511061256u565de887jf5819ff9b3b4030c@mail.gmail.com>
	(grfgguvf@gmail.com's message of "Sun, 6 Nov 2005 21:56:20 +0100")
Message-ID: <jeoe4xh22s.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<grfgguvf@gmail.com> writes:

> FreeBSD (for example) has a bootloader that can load arbitrary modules
> in addition to the kernel.
> Is there anything preventing that to be done with Linux? Or is it just
> not powerful enough?

Implementing the module loading in the boot loader means duplicating the
functionality there, making the boot loader more complex and dependent on
the loaded kernel.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
