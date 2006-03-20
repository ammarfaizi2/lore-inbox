Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWCTUgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWCTUgF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 15:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWCTUgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 15:36:05 -0500
Received: from mail.suse.de ([195.135.220.2]:52404 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030255AbWCTUgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 15:36:01 -0500
From: Andreas Schwab <schwab@suse.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Re: lstat returns bogus values.
References: <Pine.LNX.4.61.0603201312320.23345@chaos.analogic.com>
X-Yow: Of course, you UNDERSTAND about the PLAIDS in the SPIN CYCLE --
Date: Mon, 20 Mar 2006 21:35:54 +0100
In-Reply-To: <Pine.LNX.4.61.0603201312320.23345@chaos.analogic.com>
	(linux-os@analogic.com's message of "Mon, 20 Mar 2006 13:35:54 -0500")
Message-ID: <jed5ggx39x.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os (Dick Johnson)" <linux-os@analogic.com> writes:

> The "kernelly-corrected" stuff should have been returned by lstat()

What should lstat return for a cdrom device node that has no medium?
Should "ls -l /dev/cdrom" block until you have inserted a CD?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
