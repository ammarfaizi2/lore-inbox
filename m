Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbULYNuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbULYNuN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 08:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbULYNuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 08:50:13 -0500
Received: from zork.zork.net ([64.81.246.102]:43972 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261430AbULYNuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 08:50:02 -0500
From: Sean Neakums <sneakums@zork.net>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.10-ck1
References: <200412250800_MC3-1-91AD-1E8B@compuserve.com>
Mail-Followup-To: Chuck Ebbert <76306.1226@compuserve.com>, Con Kolivas
	<kernel@kolivas.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Date: Sat, 25 Dec 2004 13:49:59 +0000
In-Reply-To: <200412250800_MC3-1-91AD-1E8B@compuserve.com> (Chuck Ebbert's
	message of "Sat, 25 Dec 2004 07:57:49 -0500")
Message-ID: <6upt0ymqrc.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> writes:

> Con Kolivas wrote:
>
>> .fix_noswap.diff
>> Build fix for config without swap
>
>   So 2.6.10 won't build without swap enabled?

Built fine here.

>   This was a known problem; how did it get out the door without that fix?

It looks like a different (and cleaner) fix was applied:
#define swap_token_default_timeout 0 when CONFIG_SWAP=n.

