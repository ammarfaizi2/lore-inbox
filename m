Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbUB0AGZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUB0AGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:06:24 -0500
Received: from news.cistron.nl ([62.216.30.38]:19926 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261309AbUB0AEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:04:30 -0500
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: harddisk speed: 2.4.24 20+% faster then 2.6.3 
Date: Fri, 27 Feb 2004 00:04:29 +0000 (UTC)
Organization: Cistron
Message-ID: <c1m1id$u31$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1077840269 30817 62.216.30.38 (27 Feb 2004 00:04:29 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been checking, rechecking but cannot explain
why a "vannilla" debian install kernel (sid-testing install
cdrom) is faster then "Feisty Dunnart" on the same hardware.

hardware: Mini-itx with 1Ghz via-C3
200GB udma harddisk.

2.4.24:  
 Timing buffered disk reads:  150 MB in  3.01 seconds =  49.83 MB/sec

2.6.3 (vanilla):
 Timing buffered disk reads:  102 MB in  3.05 seconds =  33.40 MB/sec

2.6.3-mm4:
 Timing buffered disk reads:  108 MB in  3.00 seconds =  35.95 MB/sec

Bonnie tests confirm this!

hdparm & bonnie & kern.log for comparison put at: http://dth.net/c3/

Anyone any idea *why* ?

Mayby i'm overlooking something (it's kind of late on this
side of the pond) but still...

Open for feedback.

Danny

-- 
 /"\                        | Dying is to be avoided because
 \ /  ASCII RIBBON CAMPAIGN | it can ruin your whole career 
  X   against HTML MAIL     | 
 / \  and POSTINGS          | - Bob Hope

