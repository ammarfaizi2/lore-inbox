Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVJ2Iw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVJ2Iw5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 04:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVJ2Iw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 04:52:57 -0400
Received: from cantor2.suse.de ([195.135.220.15]:22487 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750830AbVJ2Iw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 04:52:56 -0400
From: Andreas Schwab <schwab@suse.de>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MACHINE_START fix
References: <20051029054301.GZ7992@ftp.linux.org.uk>
X-Yow: All of a sudden, I want to THROW OVER my promising ACTING CAREER,
 grow a LONG BLACK BEARD and wear a BASEBALL HAT!!
 ...  Although I don't know WHY!!
Date: Sat, 29 Oct 2005 10:52:52 +0200
In-Reply-To: <20051029054301.GZ7992@ftp.linux.org.uk> (Al Viro's message of
	"Sat, 29 Oct 2005 06:43:01 +0100")
Message-ID: <jefyqkogbf.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> writes:

> 	unreferenced static variables can be killed by cc(1), so when
> we want them to survive (we collect these suckers in array in special
> section), we'd better not make them static.

What about __attribute__used__?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
