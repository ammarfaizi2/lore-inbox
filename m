Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVDZBsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVDZBsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 21:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVDZBsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 21:48:17 -0400
Received: from tama55.ecl.ntt.co.jp ([129.60.39.103]:60390 "EHLO
	tama55.ecl.ntt.co.jp") by vger.kernel.org with ESMTP
	id S261236AbVDZBhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 21:37:18 -0400
Message-ID: <426D9AC0.5020908@lab.ntt.co.jp>
Date: Tue, 26 Apr 2005 10:34:56 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2-1.4.1.centos4 (X11/20050323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <4263275A.2020405@lab.ntt.co.jp> <m1y8b9xyaw.fsf@muc.de> <426C51C4.9040902@lab.ntt.co.jp> <e83d0cb60cb50a56b38294e9160d7712@mac.com>            <426CC8F7.8070905@lab.ntt.co.jp> <200504251636.j3PGa9SJ015388@turing-police.cc.vt.edu>
In-Reply-To: <200504251636.j3PGa9SJ015388@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that's the common sense in every carrier.
If we reboot the switch, the service will be disrupted.
The phone network is lifeline, and does not allow to be disrupt by just 
bug fix.
I think same kind of function is needed in many real 
enterprise/mission-critical/business area.

All do with ptrace may affect target process's time critical task. (need 
to stop target process whenever fix)
All implement in user application costs too much, need to implement all 
the application...(and I do not know this approach really works on time 
critical applications yet.)
There are clear demand to realize this common and GPL-ed function....

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 25 Apr 2005 19:39:51 +0900, Takashi Ikebe said:
> 
> 
>>Unfortunately, we carrier have very many exiting software and try to run
>>on Linux.
>>We need to seek the way which can apply to exiting software also...
> 
> 
> You *really* want to take the time to re-write the software to do things
> The Linux Way.  If you're looking at doing on-the-fly patching, you're
> probably also carrying around a lot of *other* ugly cruft to make this
> creeping horror work on Linux.  In fact, I'd not be surprised if you have
> a shim layer to make the compatibility layer for the *previous* system
> work on Linux...
> 
> I'm reminded of a (possibly apocryphal) quote from an ATT spokesperson from
> 1988 or so, when a misplaced comma in a patch kept crashing the long-distance
> phone network. When asked "Why don't you just reboot the affected switches?"
> his response was "This assumes that the switch had ever been booted in the
> first place". (Apparently, the *whole thing* had been on-the-fly replaced/patched
> without an actual reload happening...)
> 
> Gaaahhh! :)
> 

