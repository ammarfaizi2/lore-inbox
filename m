Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWFZQw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWFZQw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWFZQw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:52:29 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:41350 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750812AbWFZQwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:52:05 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 02:52:09 +1000
Subject: [Suspend2][] Dynamically Allocated Pageflags
Message-Id: <20060626165209.10918.86526.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add support for dynamically allocated pageflags, used by Suspend2 for
recording which pages are being saved in the different parts of the
image and where they're being copied to/from at atomic copy time.
