Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267199AbUGMWqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267199AbUGMWqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267204AbUGMWnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:43:50 -0400
Received: from quechua.inka.de ([193.197.184.2]:22742 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S267199AbUGMWm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:42:58 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20040713203246.GB6614@taniwha.stupidest.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BkVzC-0008E1-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 14 Jul 2004 00:42:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040713203246.GB6614@taniwha.stupidest.org> you wrote:
> running the code and pressing reset or similar

hmm... perhaps an LD_PRELOAD wrapper (based  on fakeroot) which logs all
filenames of writes with no fsync (in addition to renames and unlinks) may
easyly allow to find them by name.

let me check that out, it could even overwrite close() (which will for sure
make the system slower)

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
