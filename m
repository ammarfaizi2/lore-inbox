Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUITMvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUITMvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 08:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266474AbUITMvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 08:51:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:9383 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266473AbUITMvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 08:51:11 -0400
To: Olaf Hering <olh@suse.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
References: <20040920105618.GB24928@suse.de>
	<Pine.LNX.4.61.0409201311050.3460@scrub.home>
	<20040920112607.GA19073@suse.de>
	<Pine.LNX.4.61.0409201331320.3460@scrub.home>
	<20040920115032.GA21631@suse.de>
	<Pine.LNX.4.61.0409201357540.877@scrub.home>
	<20040920120752.GA23315@suse.de>
	<Pine.LNX.4.61.0409201413030.877@scrub.home>
	<20040920121949.GA24304@suse.de>
	<Pine.LNX.4.61.0409201428430.3460@scrub.home>
	<20040920123828.GA25684@suse.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Yes, but will I see the EASTER BUNNY in skintight leather
 at an IRON MAIDEN concert?
Date: Mon, 20 Sep 2004 14:51:08 +0200
In-Reply-To: <20040920123828.GA25684@suse.de> (Olaf Hering's message of
 "Mon, 20 Sep 2004 14:38:28 +0200")
Message-ID: <je1xgxxfwj.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> writes:

> Sure I have tried it. I wonder why umount doesnt do the losetup?

umount should only call losetup if mount did it too.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
