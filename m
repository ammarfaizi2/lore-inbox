Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965370AbWHONRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965370AbWHONRv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 09:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbWHONRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 09:17:50 -0400
Received: from reiner-h.de ([83.151.27.91]:19670 "EHLO reiner-h.de")
	by vger.kernel.org with ESMTP id S965370AbWHONRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 09:17:50 -0400
From: Reiner Herrmann <reiner@reiner-h.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc4: freeze with wistron_btns driver
Date: Tue, 15 Aug 2006 15:17:57 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Miloslav Trmac <mitr@volny.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608151517.57833.reiner@reiner-h.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After loading the wistron_btns driver in 2.6.18-rc4 and pressing some buttons
that become enabled by this driver, the kernel suddenly freezes.

The reason seems to be git-commit c7948989f84ee6e9c68cc643f8c6a635eb7a904b.
After reversing this patch everything is running fine, except that there
are again the 'section reference mismath' warnings that have been fixed
by the commit.
