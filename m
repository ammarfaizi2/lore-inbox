Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263883AbTLARfH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 12:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTLARfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 12:35:07 -0500
Received: from c145167.adsl.hansenet.de ([213.39.145.167]:2689 "EHLO
	backstube.kicks-ass.org") by vger.kernel.org with ESMTP
	id S263883AbTLARfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 12:35:03 -0500
Date: Mon, 1 Dec 2003 18:33:38 +0100
From: Alexander Heuer <roggenbrot@backstube.kicks-ass.org>
To: linux-kernel@vger.kernel.org
Subject: weird irda problem with 2.6 kernel and ericsson phone
Message-Id: <20031201183338.59d30290.roggenbrot@backstube.kicks-ass.org>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I am currently experiencing a weird problem using /dev/ircomm0 to connect to my Sony Ericsson t68i mobile phone using Debian GNU/Linux and Kernel 2.6.0-test11.

Upon trying to connect via /dev/ircomm0 using dip -t or minicom, I get the following kernel message:

"Detected buggy peer, adjust mtt to 10us"

After reading on the lists and living in google for days, I found some posts from Jean Tourrilhes, where he is writing about a connection problem due to a kernel irda problem and / or buggy Ericsson phones.
(i.e. http://www.ussg.iu.edu/hypermail/linux/kernel/0306.2/1964.html)

Either way, after checking on his patch I recognized, that the 2.6 kernel doesnt really differ from his proposal. 
I then tried playing around with sysctl_min_tx_turn_time but unfortunately... this didn't help either.

Connecting to the phone works fine on my old 2.4.19 so now I am wondering if anyone here has a similar problem after upgrading the kernel.
Since the only usable messages I found so far regarding this problem were from mailing lists, I figured this might be the best place to ask.

The funny thing I maybe should tell you as well is, I have no problems connecting to a friends mobile, which is actually a siemens.

Thanks in advance for your answers and your time

Alexander Heuer

-- 
roggenbrot@backstube.kicks-ass.org
[X] <--- Nail here for new Monitor!
