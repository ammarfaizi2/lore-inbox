Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVBBS6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVBBS6X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 13:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVBBSzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 13:55:39 -0500
Received: from ns.suse.de ([195.135.220.2]:62394 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262689AbVBBSod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 13:44:33 -0500
To: linux-os@analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Joe User DOS kills Linux-2.6.10
References: <Pine.LNX.4.61.0502021314340.5410@chaos.analogic.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I hope the ``Eurythmics'' practice birth control...
Date: Wed, 02 Feb 2005 19:44:21 +0100
In-Reply-To: <Pine.LNX.4.61.0502021314340.5410@chaos.analogic.com> (linux-os's
 message of "Wed, 2 Feb 2005 13:23:43 -0500 (EST)")
Message-ID: <jepsziby4a.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os <root@chaos.analogic.com> writes:

> When I compile and run the following program:
>
> #include <stdio.h>
> int main(int x, char **y)
> {
>     pause();
> }
> ... as:
>
> ./xxx `yes`

This is roughly equivalent to this:

#include <stdlib.h>
int main(void) { while (1) malloc(1); }

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
