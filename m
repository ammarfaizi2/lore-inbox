Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbUL3IZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUL3IZA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 03:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbUL3IZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 03:25:00 -0500
Received: from quechua.inka.de ([193.197.184.2]:18851 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261568AbUL3IY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:24:59 -0500
From: Bernd Eckenfels <ecki-news2004-12@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Is CAP_SYS_ADMIN checked by every program !?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <200412301640.FCB13564.FtFPMSMGJtSOLVOYN@i-love.sakura.ne.jp>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CjvcA-0002Om-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 30 Dec 2004 09:24:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200412301640.FCB13564.FtFPMSMGJtSOLVOYN@i-love.sakura.ne.jp> you wrote:
> But anyway, I have to give up checking for CAP_SYS_ADMIN .

You can add dump_stack(void) from kernel.h to you patch, since there are not
many sources for SYS_ADMIN capabilities checks in the kernel. You will
quickly find the syscall in question.

Greetings
Bernd
y
