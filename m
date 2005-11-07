Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbVKGRvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbVKGRvu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbVKGRvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:51:50 -0500
Received: from main.gmane.org ([80.91.229.2]:53741 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965015AbVKGRvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:51:49 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Dick <dm@chello.nl>
Subject: SIGALRM ignored
Date: Mon, 7 Nov 2005 17:36:29 +0000 (UTC)
Message-ID: <loom.20051107T183059-826@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 62.163.56.10 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051012 Firefox/1.0.7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've got a problem with SUSE LINUX Enterprise Server 9 (i586) patchlevel 2,
Linux 2.6.5-7.191-smp.

When I do the following (from bash):

trap 'echo bla' 14 ; /bin/kill -14 $$

nothing happens, utilities like iostat and netperf (and likely other utilities)
won't work due to this problem.

I've checked the glibc installation (rpm -V) and it's unchanged, bash and all
it's dependencies are also fine.

The kernel is unchanged from the SuSE LINUX Enterprise Server.

Could someone please help?

Thanks in advance,
Dick

