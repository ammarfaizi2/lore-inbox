Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbUL3EpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUL3EpN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 23:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbUL3EpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 23:45:13 -0500
Received: from quechua.inka.de ([193.197.184.2]:10908 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261531AbUL3EpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 23:45:10 -0500
From: Bernd Eckenfels <ecki-news2004-12@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Is CAP_SYS_ADMIN checked by every program !?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <200412291347.JEH41956.OOtStPFFNMLJVGMYS@i-love.sakura.ne.jp>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CjsBP-0001RC-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 30 Dec 2004 05:45:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200412291347.JEH41956.OOtStPFFNMLJVGMYS@i-love.sakura.ne.jp> you wrote:
> even for programs such as cat(1) sed(1) ls(1).

You you tried strace, if it is actually the user mode which is doing that?
If yes, then it might be a libc issue. Perhaps hwcap or something line this.
libc for example disables some features if running suid. Maybe those checks
result in checking capabilities.

Greetings
Bernd
