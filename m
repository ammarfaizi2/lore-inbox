Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWG0Vyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWG0Vyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWG0Vyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:54:33 -0400
Received: from hera.kernel.org ([140.211.167.34]:63946 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750764AbWG0Vyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:54:32 -0400
Date: Thu, 27 Jul 2006 18:30:19 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: linux-kernel@vger.kernel.org, Willy Tarreau <willy@w.ods.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Linux v2.4.33-rc3 (and a new v2.4 maintainer)
Message-ID: <20060727213019.GA10677@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes the third (and hopefully last) release candidate of v2.4.33.

It contains a fix for CVE-2006-2935 (locally exploitable typo in DVD
code), ethtool oopses and an ext3 block bitmap leakage issue.

Willy Tarreau has stepped up to maintain the mainline v2.4 tree, and
will do so starting from v2.4.34.

He has devoted great effort to help maintenance for the past few years.
His -hotfix tree is quite popular amongst v2.4 users, for instance.

I feel very confident in his competence for the job, knowing his good
common sense and great technical/communication skills.

Thanks Willy!


Summary of changes from v2.4.33-rc2 to v2.4.33-rc3
============================================

Andreas Haumer:
      [PATCH-2.4] Typo in cdrom.c

Kirill Korotaev:
      EXT3: ext3 block bitmap leakage

Marcelo Tosatti:
      Change VERSION to 2.4.33-rc3

Willy Tarreau:
      ethtool: two oopses in ethtool_set_coalesce() and ethtool_set_pauseparam()

