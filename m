Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbTFMCsC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 22:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbTFMCsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 22:48:02 -0400
Received: from quechua.inka.de ([193.197.184.2]:38104 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265109AbTFMCsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 22:48:01 -0400
From: Bernd Eckenfels <ecki-lkm@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcc3.3 Eliminate Unused Static Functions
In-Reply-To: <20030613001743.8952F2C23B@lists.samba.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19Qeoz-0004CM-00@calista.inka.de>
Date: Fri, 13 Jun 2003 05:01:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030613001743.8952F2C23B@lists.samba.org> you wrote:
> D: Results (all with gcc 3.3)
> D:   Without patch:
> D:       -rwxrwxr-x    1 rusty    rusty     5115166 Jun 13 09:17 vmlinux
> D:   With patch:
> D:       -rwxrwxr-x    1 rusty    rusty     5115166 Jun 13 09:58 vmlinux
> D:   Without patch (small unused function added):
> D:       -rwxrwxr-x    1 rusty    rusty     5115195 Jun 13 10:14 vmlinux
> D:   With patch (small unused function added):
> D:       -rwxrwxr-x    1 rusty    rusty     5115166 Jun 13 10:15 vmlinux

does that mean the current linux source tree does not benefit in any way
from this patch?

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
