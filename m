Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbUKPKyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbUKPKyq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 05:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbUKPKyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 05:54:46 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:46747 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261824AbUKPKyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 05:54:44 -0500
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU hogs ignoring SIGTERM (unkillable processes)
References: <4198A766.28114.106DD7B@rkdvmks1.ngate.uni-regensburg.de>
	<4199C06E.14572.3113A6@rkdvmks1.ngate.uni-regensburg.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I represent a sardine!!
Date: Tue, 16 Nov 2004 11:42:41 +0100
In-Reply-To: <4199C06E.14572.3113A6@rkdvmks1.ngate.uni-regensburg.de> (Ulrich
 Windl's message of "Tue, 16 Nov 2004 08:55:09 +0100")
Message-ID: <je4qjqxefy.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:

> On 15 Nov 2004 at 14:39, Andreas Schwab wrote:
>
>> "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:
>> 
>> > Hello,
>> >
>> > today I've discovered a programming error in one of my programs (that's fixed 
>> > already). When trying to replace the binary, I found out that the processes seem 
>> > unaffected by a plain "kill": They just continue to consume CPU. However, a "kill 
>> > -9" terminates them. ist that intended behavior? I guess not. Here are some facts:
>> 
>> Are you sure it doesn't block or ignore the signal?
>
> Andreas,
>
> I don't mess with signals (as said);

That is not required.  It could just as well inherit the setting from the
parent.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
