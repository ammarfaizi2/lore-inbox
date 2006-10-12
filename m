Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWJLLtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWJLLtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 07:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWJLLtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 07:49:10 -0400
Received: from cantor.suse.de ([195.135.220.2]:46249 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751309AbWJLLtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 07:49:08 -0400
From: Andreas Schwab <schwab@suse.de>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] use %p for pointers
References: <E1GXPU5-0007Ss-HU@ZenIV.linux.org.uk>
	<Pine.LNX.4.61.0610111316120.26779@yvahk01.tjqt.qr>
	<20061011145441.GB29920@ftp.linux.org.uk> <452D3BB6.8040200@zytor.com>
	<17710.8478.278820.595718@gargle.gargle.HOWL>
X-Yow: They don't hire PERSONAL PINHEADS, Mr. Toad!
Date: Thu, 12 Oct 2006 13:49:00 +0200
In-Reply-To: <17710.8478.278820.595718@gargle.gargle.HOWL> (Nikita Danilov's
	message of "Thu, 12 Oct 2006 15:03:58 +0400")
Message-ID: <jehcy9rbyr.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <nikita@clusterfs.com> writes:

> man 3 printf:
>
>        p      The void * pointer argument is printed in hexadeci-
>               mal (as if by %#x or %#lx).
>
> so %p already has to output '0x',

That is an detail of this particular implementation.

> it's lib/vsprintf.c to blame for non-conforming behavior.

The standard makes it completely implementation defined.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
