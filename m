Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbTI2HVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 03:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTI2HVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 03:21:55 -0400
Received: from quechua.inka.de ([193.197.184.2]:166 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262859AbTI2HUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 03:20:46 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Why Sysrq+k does not offer a trusted path
Organization: Deban GNU/Linux Homesite
In-Reply-To: <Pine.LNX.4.44.0309290836460.16991-100000@picard.science-computing.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.1-20030907 ("Sandray") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E1A3sKK-0004Tn-00@calista.inka.de>
Date: Mon, 29 Sep 2003 09:20:12 +0200
X-Scanner: exiscan *1A3sKK-0004Tn-00*przFs0jUnfs*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0309290836460.16991-100000@picard.science-computing.de> you wrote:
> Thus it is a more secure way to offer a real SAK.

Well, root can still disabled it, for example by debugging kernel memory.
Generally, unless you ise priveledges, you cant avoid having root disable
SAK. But this is not the real problem anyway. SAK is supposed to protect
users from other non priveledged users. The main problem with SAK are
various graphical console modes, which cant be easyly restored. I think
currently SAK is not interpreted in all keyboard modes, do avoid somebody to
kill off the console in a inconsitent state. There are for example some
X-Servers which need to reset the text mode by themself or the display is
lost.


Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
