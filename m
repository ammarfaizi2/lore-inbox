Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbULTCTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbULTCTD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 21:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbULTCTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 21:19:03 -0500
Received: from smtp.nuvox.net ([64.89.70.9]:11672 "EHLO
	smtp04.gnvlscdb.sys.nuvox.net") by vger.kernel.org with ESMTP
	id S261390AbULTCTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 21:19:00 -0500
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
From: Dan Dennedy <dan@dennedy.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Ben Collins <bcollins@debian.org>,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041220015320.GO21288@stusta.de>
References: <20041220015320.GO21288@stusta.de>
Content-Type: text/plain
Date: Sun, 19 Dec 2004 21:10:10 -0500
Message-Id: <1103508610.3724.69.camel@kino.dennedy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 02:53 +0100, Adrian Bunk wrote:
> The patch below removes 41 unneeded EXPORT_SYMBOL's.

Unneeded according to whom, just you? These functions are part of an
API. How do I know someone is not using these in a custom ieee1394
kernel module in some industrial or research setting or something new
under development to be contributed to linux1394 project?


