Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266622AbUHOMHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUHOMHu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 08:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266654AbUHOMHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 08:07:49 -0400
Received: from quechua.inka.de ([193.197.184.2]:18147 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S266622AbUHOMHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 08:07:48 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove obsolete HEAD in top Makefile
Organization: Deban GNU/Linux Homesite
In-Reply-To: <411F3A48.2030201@greatcn.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BwJne-0006M7-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 15 Aug 2004 14:07:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <411F3A48.2030201@greatcn.org> you wrote:
> Now the 2.6 kbuild is no longer using it. I have tested it.
...
> -head-y += $(HEAD)
> vmlinux-objs := $(head-y) $(init-y) $(core-y) $(libs-y) $(drivers-y) 
> $(net-y)


iff it is not using it you need to remove it in the next line, too.

Gruss
Bernd
-- 
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
