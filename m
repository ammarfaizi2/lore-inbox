Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266133AbUGEO7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbUGEO7G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 10:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266131AbUGEO7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 10:59:06 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:19100 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S266133AbUGEO6o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 10:58:44 -0400
Date: Mon, 5 Jul 2004 16:59:12 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: More s390 stuff.
Message-ID: <20040705145912.GA3756@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
with 2.6.7-mm6 cpu hotplug for s390 miraculously works again.
Not that I'm complaining but it's a bit strange. Oh well, here is
another update: 2 bug fix patches, 1 cleanup and 2 new features.
The patches are against -mm6, the cpu hotplug patch has one reject
if it is applied against -bk.

1) common i/o layer bug fix
2) dasd device driver bug fix
3) use debug feature in ctc driver
4) cpu hotplug support
5) cpu idle notifier

blue skies,
  Martin.

