Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270832AbTG0PRn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 11:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270847AbTG0PRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 11:17:43 -0400
Received: from quechua.inka.de ([193.197.184.2]:32399 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S270832AbTG0PRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 11:17:21 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
In-Reply-To: <1059315409.10692.215.camel@sonja>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19gnVi-00006M-00@calista.inka.de>
Date: Sun, 27 Jul 2003 17:32:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1059315409.10692.215.camel@sonja> you wrote:
> A device layer that shuffles around sectors would have interesting
> semantics, like hardly being portable because one would have to use
> exactly the same device driver with the same parameters to use the
> filesystem and thus retrieve the data.

In fact it should not shuffle around, but support the filesystem in
requesting new free blocks.

But I see that FS must support the flash by for example beeing prepared to
move often used blocks (super blocks, bitmaps, ... ) around.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
