Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269189AbUIYCdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269189AbUIYCdo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 22:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269190AbUIYCdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 22:33:44 -0400
Received: from quechua.inka.de ([193.197.184.2]:911 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S269189AbUIYCdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 22:33:41 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: mlock(1)
Organization: Deban GNU/Linux Homesite
In-Reply-To: <200409250147.i8P1kxtm016914@turing-police.cc.vt.edu>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CB2NY-0000q6-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sat, 25 Sep 2004 04:33:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200409250147.i8P1kxtm016914@turing-police.cc.vt.edu> you wrote:
> If the mkswap doesn't nuke the filesystem, the first time we actually
> send a page to swap will do the job.

You do not send a page to a device with no swap signature, and you do not
attach swap in a cryptoloop without a valid content.

Gruss
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
