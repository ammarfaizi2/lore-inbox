Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267683AbUIHPSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267683AbUIHPSW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 11:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268255AbUIHPSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 11:18:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:14013 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267683AbUIHPSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 11:18:21 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_CMDLINE broken on ppc
References: <20040908134028.GB15209@suse.de>
	<20040908135211.GA26381@smtp.west.cox.net>
From: Andreas Schwab <schwab@suse.de>
X-Yow: On SECOND thought, maybe I'll heat up some BAKED BEANS and
 watch REGIS PHILBIN..  It's GREAT to be ALIVE!!
Date: Wed, 08 Sep 2004 17:18:19 +0200
In-Reply-To: <20040908135211.GA26381@smtp.west.cox.net> (Tom Rini's message
 of "Wed, 8 Sep 2004 06:52:11 -0700")
Message-ID: <je8ybkg56s.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> writes:

> This has come up before, actually.  What happens if CMDLINE isn't set,
> and we don't terminate cmd_line here?  It's part of the BSS and is
> zero'd out anyways?

If BSS is not cleared that would be a bug.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
