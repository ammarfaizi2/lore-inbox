Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVESWPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVESWPX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 18:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVESWPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 18:15:22 -0400
Received: from ns.suse.de ([195.135.220.2]:50356 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261277AbVESWPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:15:16 -0400
From: Andreas Schwab <schwab@suse.de>
To: Ben Greear <greearb@candelatech.com>
Cc: Chris Friesen <cfriesen@nortel.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-os@analogic.com,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       "Gilbert, John" <JGG@dolby.com>, linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
	<20050518195337.GX5112@stusta.de>
	<6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
	<20050519112840.GE5112@stusta.de>
	<Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
	<1116505655.6027.45.camel@laptopd505.fenrus.org>
	<428CCD19.6030909@candelatech.com> <428CCE87.2010308@nortel.com>
	<428CCFA7.6010206@candelatech.com>
X-Yow: Wait..  is this a FUN THING or the END of LIFE in Petticoat Junction??
Date: Fri, 20 May 2005 00:14:55 +0200
In-Reply-To: <428CCFA7.6010206@candelatech.com> (Ben Greear's message of "Thu,
	19 May 2005 10:40:55 -0700")
Message-ID: <jeacmqg8ww.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

> Chris Friesen wrote:
>> Ben Greear wrote:
>> 
>>> It can be helpful to know what HZ you are running at, for instance if
>>> you care
>>> very much about the (average) precision of a select/poll timeout.
>> If you move the binary to a different system (or upgrade the kernel, for
>> that matter) the assumptions can be totally wrong.
>> This should be checked at runtime, not compile time.
>
> If course...that is why I like the idea of some system call or standard API
> to get the information.

sysconf(3)

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
