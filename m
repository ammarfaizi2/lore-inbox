Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVFAXjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVFAXjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVFAXiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:38:16 -0400
Received: from quechua.inka.de ([193.197.184.2]:62660 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261499AbVFAXhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:37:20 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: How to replace an executing file on an embedded system?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <Pine.LNX.4.61.0506011828300.5925@chaos.analogic.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1Ddclx-0002MM-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 02 Jun 2005 01:37:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.61.0506011828300.5925@chaos.analogic.com> you wrote:
> What am I missing?  How am I supposed to replace files that
> are being executed?

The problem is that a unlinked file which is open will be removed from the
filesystem on close. I think this is not new. You can make init reexecute
itself (telinit u)

Gruss
Bernd
