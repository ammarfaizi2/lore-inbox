Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263304AbUFNXOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbUFNXOF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 19:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUFNXOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 19:14:05 -0400
Received: from quechua.inka.de ([193.197.184.2]:23986 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263304AbUFNXOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 19:14:03 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_NOATIME support
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20040614224006.GD1961@flower.home.cesarb.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1Ba0eP-0002ef-00@calista.eckenfels.6bone.ka-ip.net>
Date: Tue, 15 Jun 2004 01:14:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040614224006.GD1961@flower.home.cesarb.net> you wrote:
> superuser). The only thing O_NOATIME gains is the absence of a race
> condition where another program can read the file without it being noted
> in the atime.

And it will not dirty the inode, which is a fairly big saving for filesystem
scanning tools.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
