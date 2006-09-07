Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWIGJiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWIGJiQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 05:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWIGJiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 05:38:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:22174 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751185AbWIGJiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 05:38:13 -0400
From: Andreas Schwab <schwab@suse.de>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: jakub@redhat.com, sebastien.dugue@bull.net, arjan@infradead.org,
       mingo@redhat.com, linux-kernel@vger.kernel.org, pierre.peiffer@bull.net,
       drepper@redhat.com
Subject: Re: NPTL mutex and the scheduling priority
References: <20060613.010628.41632745.anemo@mba.ocn.ne.jp>
	<20060907.171158.130239448.nemoto@toshiba-tops.co.jp>
	<20060907083244.GA12531@devserv.devel.redhat.com>
	<20060907.183013.55145698.nemoto@toshiba-tops.co.jp>
X-Yow: It's OBVIOUS..  The FURS never reached ISTANBUL..  You were
 an EXTRA in the REMAKE of ``TOPKAPI''..  Go home to your
 WIFE..  She's making FRENCH TOAST!
Date: Thu, 07 Sep 2006 11:37:54 +0200
In-Reply-To: <20060907.183013.55145698.nemoto@toshiba-tops.co.jp> (Atsushi
	Nemoto's message of "Thu, 07 Sep 2006 18:30:13 +0900 (JST)")
Message-ID: <je7j0grp8t.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atsushi Nemoto <nemoto@toshiba-tops.co.jp> writes:

> And ENOTSUP is not enumerated in ERRORS section of pthread_mutex_init.

POSIX does not forbid additional error conditions, as long as the
described conditions are properly reported with the documented error
numbers.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
