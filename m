Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272075AbTG2Un2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272115AbTG2Un1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:43:27 -0400
Received: from zeke.inet.com ([199.171.211.198]:37804 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S272075AbTG2UnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:43:25 -0400
Message-ID: <3F26DC68.3010000@inet.com>
Date: Tue, 29 Jul 2003 15:43:20 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030708
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: linux-kernel@vger.kernel.org, pgw99@doc.ic.ac.uk
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
References: <200307292038.h6TKcqlu000338@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
>>>This patch adds an abstraction layer for programmable LED devices,
>>>hardware drivers for the Status LEDs found on some Intel PIIX4E based
>>>server hardware (notably the ISP1100 1U rackmount server) and LEDs wired
>>>to the parallel port data lines.
>>
>>I haven't had chance to test this yet, but I really like the idea - by
>>an amasing co-incidence, I was actually thinking about the possibility
>>of doing a parallel port connected front panel earlier today!
>>
>>Does anybody have any suggestions for recommended standard uses for
>>parallel port connected LEDs?
>>
>>Disk spinning up/disk ready
>>Root login active
>>
>>Any other suggestions?
> 
> 
> Ah, I just thought, for debugging purposes we could have LEDs for:
> 
> * BKL taken
> * Servicing interrupt
> * Kernel stack usage > 2K

Maybe also:
  * 100% CPU usage
  * Toggle each jiffie (help detect interrupts disabled)
  * User control for things like cpu/harddrive temp...
  * and of course, Morse code ;)

Have fun,

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

