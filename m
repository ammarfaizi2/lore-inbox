Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVA0RgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVA0RgV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVA0RgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:36:19 -0500
Received: from ctb-mesg4.saix.net ([196.25.240.76]:22010 "EHLO
	ctb-mesg4.saix.net") by vger.kernel.org with ESMTP id S261414AbVA0ReL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:34:11 -0500
Message-ID: <41F925FF.6000006@kroon.co.za>
Date: Thu, 27 Jan 2005 19:33:51 +0200
From: Jaco Kroon <jaco@kroon.co.za>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050110
X-Accept-Language: en, af, en-gb, en-us
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Sebastian Piechocki <sebekpi@poczta.onet.pl>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za> <20050127102507.GC2702@ucw.cz> <200501271212.24143.sebekpi@poczta.onet.pl> <20050127113158.GB2975@ucw.cz>
In-Reply-To: <20050127113158.GB2975@ucw.cz>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Thu, Jan 27, 2005 at 12:12:23PM +0100, Sebastian Piechocki wrote:
> 
>>Dnia czwartek, 27 stycznia 2005 11:25, Vojtech Pavlik napisa³:
>>
>>>On Thu, Jan 27, 2005 at 08:23:07AM +0200, Jaco Kroon wrote:
>>>
>>>>Sebastian Piechocki wrote:
>>>>
>>>>>As I said I'm sending you mails from kernel masters:)
>>>>
>>>>Thanks.
>>>>
>>>>
>>>>>If you haven't such a problem, please send them your dmesg with
>>>>>i8042.debug and acpi=off.
>>>>
>>>>I made an alternative plan.  I applied a custom patch that gives me
>>>>far less output and prevents scrolling and gets what I hope is what
>>>>is required.
>>>
>>>... could you just increase the timeout value to some insane amount?
>>>That should take care of the AUX_LOOP output getting back only after
>>>issuing the next command.
>>
>>Increasing the timeout doesn't help. I've increased timout ten times and 
>>the result is the same.
> 
>  
> OK, in that case the BIOS i8042 emulation just interferes badly with the
> real i8042 and I doubt we can do much else than keep the BIOS from
> interfering.
> 
And just how do we do that?

-- 
There are only 10 kinds of people in this world,
   those that understand binary and those that don't.
http://www.kroon.co.za/
