Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUH3Wdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUH3Wdt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 18:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUH3Wds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 18:33:48 -0400
Received: from cantor.suse.de ([195.135.220.2]:45761 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264954AbUH3WcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 18:32:13 -0400
To: neroden@fastmail.fm (Nathanael Nerode)
Cc: linux-kernel@vger.kernel.org
Subject: Re: TG3(Tigoon) & Kernel 2.4.27
References: <20040830221638.GA3596@fastmail.fm>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'm ANN LANDERS!!  I can SHOPLIFT!!
Date: Tue, 31 Aug 2004 00:32:12 +0200
In-Reply-To: <20040830221638.GA3596@fastmail.fm> (Nathanael Nerode's message
 of "Mon, 30 Aug 2004 18:16:38 -0400")
Message-ID: <jehdqk45qr.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

neroden@fastmail.fm (Nathanael Nerode) writes:

> You can use simple assembler trickery to pack it up into a
> normal object file *if* you have an assembler for mips *and* you know whether
> the chip is running little-endian or big-endian (I have no idea). You may
> need other information as well.  :-P  Then and only then can you try to
> dissassemble it with objdump.

You don't have to pack it up, objdump can also disassemble raw data (with
--target=binary, --disassemble-all and suitable --architecture).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
