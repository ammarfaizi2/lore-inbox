Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbVESOGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVESOGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 10:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbVESOGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 10:06:35 -0400
Received: from ns1.suse.de ([195.135.220.2]:6070 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262509AbVESOGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:06:33 -0400
From: Andreas Schwab <schwab@suse.de>
To: linux-os@analogic.com
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, "Gilbert, John" <JGG@dolby.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
	<20050518195337.GX5112@stusta.de>
	<6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
	<20050519112840.GE5112@stusta.de>
	<Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
	<1116505655.6027.45.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl>
	<Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com>
X-Yow: WHY are we missing KOJAK?
Date: Thu, 19 May 2005 16:06:23 +0200
In-Reply-To: <Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com> (Richard
	B. Johnson's message of "Thu, 19 May 2005 09:01:19 -0400 (EDT)")
Message-ID: <jeacmr5mzk.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <linux-os@analogic.com> writes:

> Now, where is that 'auxiliary vevtor'??? I got a pointer to
> something to be executed before calling exit, I have an
> argument count, then a bunch of pointers (argv), terminating
> with a NULL, then another bunch of pointers (envp) terminating
> with a NULL.  Is there something after that??? If so, what's
> the contents of this thing?

See create_elf_tables.  The aux table comes after the environment.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
