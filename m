Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbUCHV4S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUCHV4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:56:02 -0500
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:5860 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S261289AbUCHVxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:53:49 -0500
Message-ID: <404CEB67.9000101@uni-paderborn.de>
Date: Mon, 08 Mar 2004 22:53:43 +0100
From: Bjoern Schmidt <lucky21@uni-paderborn.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: fsb of older cpu
References: <404C4D32.1080609@uni-paderborn.de> <200403081714.04182.bernd.schubert@pci.uni-heidelberg.de> <404CD4E7.5050105@uni-paderborn.de> <404CE0FC.8070900@stesmi.com>
In-Reply-To: <404CE0FC.8070900@stesmi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.uni-paderborn.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski schrieb:
> I'm no expert on the subject but as I recall the processor sets the
> internal clock (derived from fsb+multiplier) on startup so no matter
> what you do do the running cpu it won't change it.

I think there must be a way. In the BIOS there ist an option "half processor
clock it is in idle". One time i have seen in /proc/cpuinfo" that the clock
was at ~118MHz, but that is 6 Month ago and i have this never seen again...
The problem is that with activated acpi the passive cooling does not seem to 
work although the cpu is very often in C2 and throttling mode is at 8. C1 is 
called extrem rarely (~1000 times per day), even if the system is under heavy
load for a long time. I believe that C2 is not really supported by the cpu.

-- 
Greetings
Bjoern Schmidt


