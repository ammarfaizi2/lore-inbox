Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWDJUfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWDJUfz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 16:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWDJUfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 16:35:55 -0400
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:52432 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932129AbWDJUfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 16:35:54 -0400
To: akpm@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] locks: fixes and cleanups
Message-Id: <E1FT36W-0004KP-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Apr 2006 22:35:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are small changes to the POSIX locking code:

1) fix an improbable memory leak in case of OOM

2) optimize away memory allocations if not needed

3) use common code in locks_remove_posix()

Miklos
