Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVAPBLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVAPBLs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 20:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVAPBLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 20:11:47 -0500
Received: from washoe.rutgers.edu ([165.230.95.67]:41891 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S262372AbVAPBLo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 20:11:44 -0500
Date: Sat, 15 Jan 2005 20:11:44 -0500
From: Yaroslav Halchenko <list-kernel@onerussian.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: wifi craziness: hermes_read_ltv(): rid  (0xfd43) does not match type (0xfdc6)
Message-ID: <20050116011144.GB14489@washoe.rutgers.edu>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Developers,

Since I've secured WiFi card (internal of Vaio PCG-v505ACK) using WEP I get my logs filled in with
message which start appearing after putting some load on the connection
(torrents)

hermes @ MEM 0xf98ca000: hermes_read_ltv(): rid  (0xfdc6) does not match type (0xfd44)
hermes @ MEM 0xf98ca000: hermes_read_ltv(): rid  (0xfd43) does not match type (0xfdc6)
hermes @ MEM 0xf98ca000: Truncating LTV record from 10 to 6 bytes.(rid=0xfd43, len=0x0006)

What can be a reason? I'm running the recent kernel patched with swsusp2 

Details of the system (config, more messages, lspci etc) can be found 
http://www.onerussian.com/Linux/bugs/badwifi/

Thank you in advance

-- 
Yaroslav Halchenko
Research Assistant, Psychology Department, Rutgers-Newark
Office: (973) 353-5440x263 | FWD: 82823 | Fax: (973) 353-1171
Student  Ph.D. @ CS Dept. NJIT, Master @ CS Dept. UNM
lynx -source http://www.onerussian.com/gpg-yoh.asc | gpg --import
GPG fingerprint   3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
