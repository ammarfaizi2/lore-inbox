Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVFUAFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVFUAFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVFUAD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:03:27 -0400
Received: from mail.suse.de ([195.135.220.2]:41151 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261801AbVFTXiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:38:14 -0400
From: Andreas Schwab <schwab@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
       Jeremy Maitin-Shepard <jbms@cmu.edu>,
       Patrick McFarland <pmcfarland@downeast.net>,
       Alexey Zaytsev <alexey.zaytsev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <f192987705061303383f77c10c@mail.gmail.com>
	<f192987705061310202e2d9309@mail.gmail.com>
	<1118690448.13770.12.camel@localhost.localdomain>
	<200506152149.06367.pmcfarland@downeast.net>
	<20050616023630.GC9773@thunk.org> <87y89a7wfn.fsf@jbms.ath.cx>
	<20050616143727.GC10969@thunk.org> <20050619175503.GA3193@elf.ucw.cz>
	<1119292723.3279.0.camel@localhost.localdomain>
	<20050620221926.GJ2222@elf.ucw.cz>
X-Yow: I want another RE-WRITE on my CAESAR SALAD!!
Date: Tue, 21 Jun 2005 01:38:12 +0200
In-Reply-To: <20050620221926.GJ2222@elf.ucw.cz> (Pavel Machek's message of
	"Tue, 21 Jun 2005 00:19:26 +0200")
Message-ID: <jeu0jswqe3.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
>
>> > Actually the day we have rm utf-8-ed, we have a problem. Someone will
>> > create two files that have same utf name, encoded differently, and
>> > will be in trouble. Remember old > \* "hack"? utf-8 makes variation
>> > possible...
>> 
>> They are different to POSIX as they are different byte sequences
>
> Does POSIX really say that all weird characters must be accepted in
> path name?

POSIX only requires [A-Za-z0-9._-].

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
