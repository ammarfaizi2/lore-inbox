Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbULFLPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbULFLPD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 06:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbULFLPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 06:15:02 -0500
Received: from ns1.enidan.ch ([217.8.216.11]:28123 "EHLO mail.local.net")
	by vger.kernel.org with ESMTP id S261501AbULFLOv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 06:14:51 -0500
From: Per Jessen <per@computer.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.28 - kswapd excessive cpu usage under heavy IO
Date: Mon, 6 Dec 2004 12:14:48 +0100
User-Agent: KMail/1.5.4
Organization: n/a
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200412061214.48754.per@computer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(apologies if this is sent more than once)
I've found similar incidences in the archives, but none that indicates that a
solution was found. 
I'm seeing excessive cpu usage by kswapd on a 4way 500MHZ Xeon with 2GB RAM.  A
find in a directory containing perhaps 6-700,000 files makes the box almost
grind to a halt.  In 12days uptime, kswap has used 590:43.82, and during the
find-exercise usually runs with 90-100% util.
The file-system is 150GB with JFS117 on a software-RAID5 - not exactly optimal,
I agree, but reasonably workable.

I've read that 2.6 has significant improvements in this area, but upgrading is
not currently an option.  

All hints & suggestions much appreciated.

-- 
Per Jessen, Zurich
http://www.spamcek.com - let your spam stop here.

