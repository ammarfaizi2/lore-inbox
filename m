Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265420AbTLHOLQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 09:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbTLHOLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 09:11:16 -0500
Received: from ns.suse.de ([195.135.220.2]:17080 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265420AbTLHOLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 09:11:13 -0500
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Petr Sebor <petr@scssoft.com>, linux-kernel@vger.kernel.org
Subject: Re: incorrect inode count on reiserfs
References: <3FD47BFC.9020008@scssoft.com>
	<16340.33245.887082.96412@laputa.namesys.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: BARBARA STANWYCK makes me nervous!!
Date: Mon, 08 Dec 2003 15:11:09 +0100
In-Reply-To: <16340.33245.887082.96412@laputa.namesys.com> (Nikita Danilov's
 message of "Mon, 8 Dec 2003 16:51:25 +0300")
Message-ID: <jek757762q.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> writes:

> inn2 should be fixed. :)
>
> Fix would really be simple: ignore test results if ->f_files is 0 or
> 0xffffffff.

That should better be (fsfilcnt_t)-1.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
