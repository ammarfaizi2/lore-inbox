Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTJ2KMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 05:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTJ2KMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 05:12:49 -0500
Received: from fire.yars.free.net ([193.233.48.99]:59059 "EHLO
	fire.yars.free.net") by vger.kernel.org with ESMTP id S261956AbTJ2KMs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 05:12:48 -0500
Date: Wed, 29 Oct 2003 13:12:40 +0300
From: "Alexander V. Lukyanov" <lav@netis.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9: access beyond end of device
Message-ID: <20031029101240.GA12958@night.netis.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-NETIS-MailScanner-Information: Please contact NETIS Telecom for more information (+7 0852 797709)
X-NETIS-MailScanner: Found to be clean
X-NETIS-MailScanner-SpamCheck: not spam, SpamAssassin (score=-6.6,
	required 5, AWL 0.00, BAYES_20 -2.60, USER_AGENT_MUTT -2.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried to run 2.6.0-test9 and got this error very quickly.

Details:
	heavily loaded squid server with two ext3 filesystems for cache on
	two IC35L040AVVN07-0 40GiB hard disks (ibm), TCQ enabled.

Oct 29 10:52:28 mars kernel: attempt to access beyond end of device
Oct 29 10:52:28 mars kernel: hda4: rw=0, want=4241606720, limit=77256585
Oct 29 10:52:28 mars kernel: attempt to access beyond end of device
Oct 29 10:52:28 mars kernel: hda4: rw=0, want=4241606720, limit=77256585
Oct 29 10:52:33 mars kernel: EXT3-fs error (device hda4): ext3_free_blocks: Freeing blocks not in datazone - block = 1067071751, count = 1
Oct 29 10:52:33 mars kernel: Aborting journal on device hda4.

-- 
   Alexander.
