Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWHJAPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWHJAPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWHJAPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:15:38 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:14218 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932378AbWHJAPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:15:36 -0400
Message-Id: <20060810000146.913645000@linux-m68k.org>
User-Agent: quilt/0.45-1
Date: Thu, 10 Aug 2006 02:01:46 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: [NTP 0/9] NTP patches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is my current version of the NTP patches.
They precalculate as much possible and get rid of a lot of rather crude
compensation code. The tick length is now a much simpler value, updated
once a second, which greatly reduces the dependency on HZ.
I rebased the patches against current -mm + John's ntp.c patch.

bye, Roman

--

