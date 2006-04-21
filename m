Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWDUAfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWDUAfk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWDUAfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:35:40 -0400
Received: from quechua.inka.de ([193.197.184.2]:64898 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932164AbWDUAfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:35:39 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rename "swapper" to "idle"
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <4448161D.9010109@gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FWjcX-0007Hj-00@calista.inka.de>
Date: Fri, 21 Apr 2006 02:35:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong <hzhong@gmail.com> wrote:
> This patch renames the "swapper" process (pid 0) to a more appropriate name "idle". The name "swapper" is not obviously meaningful and confuses a lot of people (e.g., when seen in oops report).
> Patch not tested, but I guess it works. :-)

on win the system idle process shows up in taskmanager so you can see its
cpu usage and ctx switches scheduled from it. We could avoid the skipping in
/proc, also?

Gruss
Bernd
