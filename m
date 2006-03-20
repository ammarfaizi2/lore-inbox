Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWCTVO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWCTVO1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbWCTVO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:14:27 -0500
Received: from mx1.suse.de ([195.135.220.2]:11195 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030326AbWCTVO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:14:26 -0500
From: Andreas Schwab <schwab@suse.de>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Who uses the 'nodev' flag in /proc/filesystems ???
References: <17436.60328.242450.249552@cse.unsw.edu.au>
X-Yow: I just got my PRINCE bumper sticker..
 But now I can't remember WHO he is...
Date: Mon, 20 Mar 2006 22:14:24 +0100
In-Reply-To: <17436.60328.242450.249552@cse.unsw.edu.au> (Neil Brown's message
	of "Sun, 19 Mar 2006 16:27:04 +1100")
Message-ID: <jewteovmxb.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> writes:

> Hence the question in the subject:
>
>   Who uses the 'nodev' flag in /proc/filesystems?
>
> Are there any known users of this flag?

mount is using it, when no explicit type is specified.  When iterating
over /proc/filesystems it ignores lines with the nodev flag.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
