Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752264AbWKASZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbWKASZv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 13:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752261AbWKASZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 13:25:51 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:9103 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1752262AbWKASZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 13:25:50 -0500
Date: Wed, 1 Nov 2006 21:25:12 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Graf <tgraf@suug.ch>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] taskstats: uglify^Woptimize reply assembling
Message-ID: <20061101182512.GA444@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last series.

Balbir, Shailabh, could you suggest me some user-space tests?

Thomas, we are doing genlmsg_cancel() before nlmsg_free(), this is
not necessary. Unless you have evil plans to complicate genetlink
we can remove a little bit of code, what do you think?

Oleg.

