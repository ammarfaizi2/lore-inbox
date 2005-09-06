Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVIFRxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVIFRxw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 13:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVIFRxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 13:53:52 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:1427 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1750740AbVIFRxw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 13:53:52 -0400
Date: Tue, 6 Sep 2005 19:53:49 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13: can kill X server but readlink of /proc/<pid>/exe et. al. says EACCES. feature?
Message-ID: <20050906175349.GA390@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While I have access to /proc/<pid>, readlink fails with EACCES on

	/proc/<pid>/exe
	/proc/<pid>/cwd
	/proc/<pid>/root

even when I own <pid> though it runs with a different effective/saved/fs
uid such as the X server. This is a bit uncomfortable and doesn't
seem right.

Or is this to make /proc mounting inside a chroot jail safe?

-- 
Frank
