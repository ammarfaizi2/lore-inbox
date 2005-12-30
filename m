Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVL3TbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVL3TbU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 14:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVL3TbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 14:31:20 -0500
Received: from quechua.inka.de ([193.197.184.2]:19590 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751296AbVL3TbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 14:31:19 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RAID controller safety
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20051230185840.52264.qmail@web34113.mail.mud.yahoo.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1EsPy9-0001KW-00@calista.inka.de>
Date: Fri, 30 Dec 2005 20:31:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20051230185840.52264.qmail@web34113.mail.mud.yahoo.com> you wrote:
> So all writes would be treated as syncronous in the write-through case (no battery), making fsync
> a no-op?

The device cache is IMHO not related to the higher level buffer cache. So
fsync flushes the buffers and the write-through ensures the controller may
not delay it in controller ram.

Gruss
Bernd
