Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268208AbUHFSqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268208AbUHFSqr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 14:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbUHFSqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 14:46:47 -0400
Received: from quechua.inka.de ([193.197.184.2]:65256 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S268208AbUHFSqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 14:46:44 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: EXT intent logging
Organization: Deban GNU/Linux Homesite
In-Reply-To: <S268180AbUHFQey/20040806163555Z+829@vger.kernel.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1Bt9jm-0001fg-00@calista.eckenfels.6bone.ka-ip.net>
Date: Fri, 06 Aug 2004 20:46:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <S268180AbUHFQey/20040806163555Z+829@vger.kernel.org> you wrote:
> But if it doesn't do writes to the journal first, how does it identify
> transactions that were "in flight" when the system went down to reverse
> them? How do you catch a parial update to an inode for instance?

the journal is about meta data, if you want data journaling, try data=journal.

Gruss
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
