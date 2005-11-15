Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbVKONzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbVKONzt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 08:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbVKONzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 08:55:49 -0500
Received: from pc-4082.ethz.ch ([129.132.119.169]:58245 "EHLO
	komsys-pc-ruf.ethz.ch") by vger.kernel.org with ESMTP
	id S932526AbVKONzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 08:55:48 -0500
Date: Tue, 15 Nov 2005 14:55:26 +0100
From: Lukas Ruf <ruf@rawip.org>
To: Linux Kernel ml <linux-kernel@vger.kernel.org>
Subject: linux-2.6.15-rc1 crashed my file system for 2.6.14
Message-ID: <20051115135526.GA24374@tik.ee.ethz.ch>
Mail-Followup-To: Linux Kernel ml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Swiss Federal Institute of Technology (ETH) Zurich
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

today, I tried linux-2.6.15-rc1 on my laptop (thinkpad t40p).
Before it had been running 2.6.14 without troubles.

What happened:

- compiled 2.6.15-rc1 with the 2.6.14 .config file.

- make install modules_install ; update-grub

- booted into 2.6.15-rc1

- started X.org (latest available in Debian unstable, DNR version)

- crashed the screen output -> rebooted

- booted in 2.6.14 (that run without problems)

- received the 'VFS ... cannot mount root ...' error message
  (ext2 and ext3 are statically compiled into the kernel)

- booted into Knoppix, fsck.ext3 didn't show any error

- retried 2.6.14 -- same error persists

- 2.6.15-rc1 boots still smoothly

- however, 2.6.15-rc1 has still no screen output after trying to
  start X.

---> how can I get back to 2.6.14 without loosing data

Any help is very welcome and urgently needed.

Thanks in advance,

wbr,
Lukas
-- 
Lukas Ruf   <http://www.lpr.ch> | Ad Personam
rbacs      <http://wiki.lpr.ch> | Restaurants, Bars and Clubs
Raw IP   <http://www.rawip.org> | Low Level Network Programming
Style  <http://email.rawip.org> | How to write emails
