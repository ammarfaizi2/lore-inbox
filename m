Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266454AbUFZVid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266454AbUFZVid (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 17:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266451AbUFZVic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 17:38:32 -0400
Received: from mail.gmx.de ([213.165.64.20]:141 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266454AbUFZViS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 17:38:18 -0400
X-Authenticated: #4512188
Message-ID: <40DDECC5.4040008@gmx.de>
Date: Sat, 26 Jun 2004 23:38:13 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040618)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wes Janzen <superchkn@sbcglobal.net>
CC: Michael Buesch <mbuesch@freenet.de>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Pauli Virtanen <pauli.virtanen@hut.fi>
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <40DC38D0.9070905@kolivas.org> <40DDD6CC.7000201@sbcglobal.net> <200406262211.24373.mbuesch@freenet.de> <40DDE74A.3090301@sbcglobal.net>
In-Reply-To: <40DDE74A.3090301@sbcglobal.net>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wes Janzen wrote:
> 
> Michael Buesch wrote:
> 
>> On Saturday 26 June 2004 22:04, you wrote:
>>
>> >Hi Con,
>>
>> >I don't know what's going on but 2.6.7-mm2 with the staircase v7.4 (with
>> >or without staircase7.4-1) takes about 3 hours to get from loading the
>> >kernel from grub to the login prompt.  Now I realize my K6-2 400 isn't
>> >state of the art...  I don't have this problem running 2.6.7-mm2.
>>
>> >It just pauses after starting nearly every service for an extended
>> >period of time.  It responds to sys-rq keys but just seems to be doing
>> >nothing while waiting.
>>
>> >Any suggestions?
>>
>>
>> Maybe same problem as mine?
>> Some init-scripts don't get their timeslices?
> 
> 
> I was wondering if not.  I didn't notice any problems while using it 
> once it had booted, but then I didn't really try to stress it much 
> either.  I'm running gentoo and have RC_PARALLEL_STARTUP="yes" set in my 
> /etc/conf.d/rc, maybe that's what makes me hit this during init whereas 
> I haven't seen anyone else mention this.

I am not using 2.6.7-mm2, but 2.6.7-ck1 with latest staircase and also 
run gentoo with parallel RC startup. I have no recognizeable delays. But 
my machine is "a bit" more modern than the k6-2 on the other hand. ;-)

Perhaps try 2.6.7-ck2 (or ck1) with latest staircase.

bye,

Prakash
