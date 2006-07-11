Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWGKAIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWGKAIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 20:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWGKAIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 20:08:35 -0400
Received: from mail.suse.de ([195.135.220.2]:57478 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751079AbWGKAIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 20:08:35 -0400
From: Andreas Schwab <schwab@suse.de>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: John Linville <linville@tuxdriver.com>, linux-kernel@vger.kernel.org
Subject: Re: Error in git pull
References: <44B2D122.6010005@lwfinger.net>
X-Yow: Could I have a drug overdose?
Date: Tue, 11 Jul 2006 02:08:24 +0200
In-Reply-To: <44B2D122.6010005@lwfinger.net> (Larry Finger's message of "Mon,
	10 Jul 2006 17:13:54 -0500")
Message-ID: <jeac7hatqf.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> I just pulled your latest changes from the wireless-2.6 repository. When I
> did so, I got the following git error:
>
> finger@larrylap:~/wireless-2.6> git pull
> Unpacking 22599 objects
>  100% (22599/22599) done
> error: no such remote ref refs/heads/zd1211rw
> * refs/heads/origin: does not fast forward to branch 'master' of
> git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6;
>   not updating.
>
> Is there any way for me to recover without pulling the entire tree again?

Use git reset --hard with the id of the head of the remote branch.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
