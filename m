Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUDQCM0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 22:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbUDQCM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 22:12:26 -0400
Received: from gherkin.frus.com ([192.158.254.49]:23943 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S261197AbUDQCMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 22:12:25 -0400
Subject: Re: [PATCH] sym53c500_cs PCMCIA SCSI driver (new)
In-Reply-To: <200404170142.24798.p_christ@hol.gr> "from P. Christeas at Apr 17,
 2004 01:42:24 am"
To: "P. Christeas" <p_christ@hol.gr>
Date: Fri, 16 Apr 2004 21:12:24 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20040417021224.1C20ADBEE@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P. Christeas wrote:
> I'm the second person in our solar system that has such a card! 
> 
> I cleanly compiled and run your module. Looks OK. I haven't yet attached any 
> peripheral, though. It's of no use to me, but I will be glad to help you by 
> testing that code (w. devices as well).
> Thanks for resurrecting the dead!

Bravo!  You've made my day :-).  What kind of devices do you have
available?  When I repair the #$%@! capstan on my Archive cartridge
tape unit, I need to test with that...  The need for tape backup was
the reason I bought my card in the first place.  At the moment, the
only device I've got that's even halfway convenient to use in testing
is an Olympus optical disk unit (removable media).  The driver works
reliably with that, but I've got a sneaking suspicion that a tape unit
would stress things a bit more (error handling and such).

Per Christoph's critique, I've successfully combined the three driver
source files into a single source file, and eliminated all the
deprecated includes as well as the structure typedefs.  Still to do:
add support for multiple HBAs, and eliminate distasteful hacks in
detection code.  Dunno how I'm going to test the multiple HBA code...

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
