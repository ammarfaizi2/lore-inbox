Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266291AbUHRNHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUHRNHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 09:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbUHRMwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 08:52:19 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:59530 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S266214AbUHRMvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 08:51:05 -0400
Date: Wed, 18 Aug 2004 14:51:04 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Bind Mount Extensions 0.05
Message-ID: <20040818125104.GA12286@MAIL.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings!

The following patch extends the 'noatime', 'nodiratime' and
last but not least the 'ro' (read only) mount option to the
vfs --bind mounts, allowing them to behave like any other
mount, by honoring those mount flags (which are silently
ignored by the current implementation in 2.4.x and 2.6.x)

I don't want to pollute your mailbox with useless patches,
so for those who are interested in this stuff, get them
here (for 2.4.27 and 2.6.8.1)
 
  http://www.13thfloor.at/patches/

many thanks to Willy Tarreau for spotting the bug in the
previous bme0.04 for linux 2.4.x.

enjoy,
Herbert

