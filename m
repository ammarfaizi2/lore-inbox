Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266361AbUGJThW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266361AbUGJThW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 15:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266358AbUGJThW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 15:37:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:65455 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266360AbUGJThN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 15:37:13 -0400
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: Chris Wedgwood <cw@f00f.org>, Jan Knutar <jk-lkml@sci.fi>,
       L A Walsh <lkml@tlinx.org>, linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx>
	<200407102143.49838.jk-lkml@sci.fi>
	<20040710184601.GB5014@taniwha.stupidest.org>
	<200407101555.27278.norberto+linux-kernel@bensa.ath.cx>
From: Andreas Schwab <schwab@suse.de>
X-Yow: But was he mature enough last night at the lesbian masquerade?
Date: Sat, 10 Jul 2004 21:33:34 +0200
In-Reply-To: <200407101555.27278.norberto+linux-kernel@bensa.ath.cx> (Norberto
 Bensa's message of "Sat, 10 Jul 2004 15:55:26 -0300")
Message-ID: <je658vwtbl.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norberto Bensa <norberto+linux-kernel@bensa.ath.cx> writes:

> Chris Wedgwood wrote:
>> XFS does not journal data.
>
> I think we all know that. The point, why the hell does it null files?

Security.  You don't want old contents of /etc/shadow appear in random
files after a crash.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
