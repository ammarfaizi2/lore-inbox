Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbUKUWIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbUKUWIA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 17:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbUKUWH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 17:07:58 -0500
Received: from pigwidgeon.lancs.ac.uk ([148.88.0.67]:27112 "EHLO
	pigwidgeon.lancs.ac.uk") by vger.kernel.org with ESMTP
	id S261840AbUKUWHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 17:07:25 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: steveb@unix.lancs.ac.uk
Date: Sun, 21 Nov 2004 22:07:24 +0100
Subject: Remove arbitrary #acl entries limits on ext[23]
Cc: agruen@suse.de
To: linux-kernel@vger.kernel.org
Message-Id: <E1CVzrg-0005he-00@wing0.lancs.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


About six months ago, Andreas Gruenbacher said:

> The second patch that removes the ACL entry limit for writes is not
> included. I don't want to push that patch now, because large ACLs would
> cause 2.4 and current 2.6 kernels to fail. My plan is to remove the
> second limit later, in a half-year or year or so. If you think we should
> go the full way I wouldn't mind, however.

(The patch to remove the limit is referenced at http://lwn.net/Articles/69839/)

Has sufficient time now passed for this patch to be reconsidered?

If not, would an acceptable compromise be to allow runtime configuration
for this limit (e.g. via sysctl)? This would preserve backwards compatibility,
but allow folk to choose their own arbitrary limits.

--
Steve Bennett
