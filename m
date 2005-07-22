Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVGVBe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVGVBe0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 21:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVGVBe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 21:34:26 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:10175 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261998AbVGVBeR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 21:34:17 -0400
Message-ID: <42E04D11.20005@ribosome.natur.cuni.cz>
Date: Fri, 22 Jul 2005 03:34:09 +0200
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Giving developers clue how many testers verified certain kernel version
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I think the discussion going on here in another thread about lack
of positive information on how many testers successfully tested certain
kernel version can be easily solved with real solution.

  How about opening separate "project" in bugzilla.kernel.org named
kernel-testers or whatever, where whenever cvs/svn/bk gatekeepers
would release some kernel patch, would open an empty "bugreport"
for that version, say for 2.6.13-rc3-git4.

  Anybody willing to join the crew who cared to download the patch
and tested the kernel would post just a single comment/follow-up
to _that_ "bugreport" with either "positive" rating or URL
of his own bugreport with some new bug. When the bug get's closed
it would be immediately obvious in the 2.6.13-rc3-git4 bug ticket
as that bug will be striked-through as closed.

  Then, we could easily just browse through and see that 2.6.13-rc2
was tested by 33 fellows while 3 of them found a problem and 2 such
problems were closed since then.

  I know what would be really helpfull if the testers would report
let's say motherboard type, HIGHMEM/NO-HIGHMEM, ACPI/NO-ACPI,
SMP/NO-SMP and few more hints and if teh database would keep those
having same hardware + config as a single record. It could even just
watch few lines in .config file when uploaded.

  Well I'm sure you got my point, maybe it would be easier to write
some tiny database from scratch instead of tweaking bugzilla to suit
this king of solution.
;-)
Martin
