Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWAYA7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWAYA7D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 19:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWAYA7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 19:59:03 -0500
Received: from lca-gtw.lca2006.linux.org.au ([202.53.187.9]:8387 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750943AbWAYA7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 19:59:02 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Suspend2 2.2 for 2.6.15.1
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Date: Wed, 25 Jan 2006 10:55:01 +1000
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601251055.02219.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone.

I should have sent this to LKML when sending it to the Suspend2 lists, but 
will make ammends by reposting now...

I'm please to be able to announce Suspend2 2.2.

In the first instance, this patch has been prepared for 2.6.15.1, but I intend 
to also prepare releases for 2.6.16-rc1 and later for current 2.4.

There is, as always, still more work to do, but this exclusively in the area 
of bug fixes (especially improving non-x86 support). I now consider Suspend2 
to be feature complete, and will be focussing on preparations for seeking to 
merge Suspend2 into the vanilla kernel.

Changelog since rc16:
- Fix amd64 page_is_ram typo.
- Fix unintentional dependence on swsusp (amd64).
- Make swapwriter select swap support instead of depending
  on it already being selected.
- Make a new common function for writing the last (partial)
  page of a header.
- Remove temporary enabling of block dump when reading pageset1.
- Extend have_image to also display some of the details from
  the header.
- Cleanup count_data_pages changes.
- Save and restore the block_dump setting when starting/finishing
  a cycle.
- Add support for debugging the image header reading & writing.
- A few fixes to the filewriter.
- Cleanups in swapwriter and arch specific code.

-- 
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode
