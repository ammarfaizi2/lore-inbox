Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUGEXim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUGEXim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 19:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUGEXim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 19:38:42 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:58769 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261987AbUGEXil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 19:38:41 -0400
Subject: quite big breakthrough in the BAD network performance, which mm6
	did not fix
From: Redeeman <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 06 Jul 2004 01:38:40 +0200
Message-Id: <1089070720.14870.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey, i have had a breakthrough in the investigation...
it turns out that some sites does not load.. but you know all about
that, and a "fix" with sysctl fixes some of it.

networking was generally slow - or not!
it seems that its only HTTP transfers going insanely slow. which also
probably is those ipv4 issues, so now we just need to figure out what
changed, and what we need to change to fix it, so that we again can get
all sites loading, and HTTP protocol fully functionel again.

hope someone has some ideas.
-- 
Regards, Redeeman
redeeman@metanurb.dk

