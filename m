Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272144AbTHIA3W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272145AbTHIA3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:29:19 -0400
Received: from quechua.inka.de ([193.197.184.2]:11694 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S272144AbTHIA3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:29:16 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org, dwmw2@infradead.org
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
In-Reply-To: <1060387128.11983.34.camel@imladris.demon.co.uk>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19lHbb-0005mY-00@calista.inka.de>
Date: Sat, 09 Aug 2003 02:29:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

In article <1060387128.11983.34.camel@imladris.demon.co.uk> you wrote:
> I've been at the receiving end of an automated powerfail script
> which has been stress-testing JFFS2 and forcibly power cycling the
> device in question every few minutes

Is this needing some special hardware support, or is it kind of forcing
apm/apci power downs? Can you publish that script? I would need that for
some stress testing of applications and the kernel.

I also wonder, what the best method is to test those hard crashes,
especially interesting is the case, where disks get power interruption at
write, to see if the filesystem and block layer recovers from things like
half written (format needing) blocks.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
