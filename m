Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268057AbUIGNzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268057AbUIGNzI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 09:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268067AbUIGNzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 09:55:08 -0400
Received: from asus.discosmash.com ([213.193.225.10]:33416 "EHLO
	asus.discosmash.com") by vger.kernel.org with ESMTP id S268057AbUIGNzC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 09:55:02 -0400
Date: Tue, 7 Sep 2004 15:55:01 +0200 (CEST)
From: Joris Neujens <joris@discosmash.com>
To: linux-kernel@vger.kernel.org
Subject: Possible network issue in 2.6.8.1
Message-ID: <Pine.LNX.4.58.0409071544570.6867@asus.discosmash.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We've got a weird problem at our university network.  Since we upgraded to
kernel 2.6.8 our download rate never gets higher than 10kB/sec.  Upload
remains at original rate.  This problem does not occur with previous
kernels (works fine again after downgrading to 2.6.7, without changing
anything at the kernel config).

There are no speed issues when transfering on the LAN, only when
downloading something from the internet

We have ruled out the following:
Network source is slow (we were testing with the same FTP server all the
time, from which we normally download at 10MB/sec)
We tested with 3 different systems and network cards, and they all have
the same problem, and only with kernel 2.6.8

any thoughts?

Regards,

Joris Neujens
Lennart Yseboodt
Michael De Nil
