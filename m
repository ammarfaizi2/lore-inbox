Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbUKFPvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbUKFPvm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 10:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUKFPvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 10:51:42 -0500
Received: from main.gmane.org ([80.91.229.2]:64167 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261409AbUKFPv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 10:51:26 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: WDC TLER (Time Limited Error Recovery) and linux kernel
Date: Sun, 07 Nov 2004 00:51:43 +0900
Message-ID: <cmirtk$fhf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041016
X-Accept-Language: bg, en, ja, ru, de
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was just browsing Western Digital's site and was looking at the new RAID edition SATA drives...

As I saw the followind note:
##
IMPORTANT: Because of the time-limited error recovery feature, this product is intended for server applications and is not recommended for use in desktop systems.
##

So I was wondering what exactly is it and how is software RAID affaceted by it...

For a quick overview of TLER:
http://www.excelmeridiandata.com/products/wd_raid_edition_drive.shtml

The "official" WDC info is here:
http://www.wdc.com/en/library/sata/2579-001098.pdf

You'll see that WDC talks about 8-second timeout by the host (RAID) adapter, but there is no such specification. Where did this 8s came from?
How is it implemented in software RAID? (haven't looked the source yet)

In other words is there any benefits or problems using TLER-enabled disks under linux (with software RAID)?
Anybody tired them?

Just some questions that came into my mind...

Kalin.

-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

