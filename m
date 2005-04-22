Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVDVAXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVDVAXF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 20:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVDVAVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 20:21:42 -0400
Received: from quechua.inka.de ([193.197.184.2]:1443 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261790AbVDVATj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 20:19:39 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ia64 git pull
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <Pine.LNX.4.58.0504211608300.2344@ppc970.osdl.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DOltP-00012K-00@calista.eckenfels.6bone.ka-ip.net>
Date: Fri, 22 Apr 2005 02:19:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0504211608300.2344@ppc970.osdl.org> you wrote:
> Why? Because I'm still using the stupid "get all objects" thing when I
> pull.

one could do a symlink/hardlink parallel tree for a specific snapshot with
GIT tools, and then only poll that with git-unaware copy tools.

I guess this would make sense for the most common kernel development lines.

Another improvement would be to add a "secondary storage fetch" script, so
the git tools can, if they cant find a object by hash just query an external
pool. In combination with the above this will allow users to compare progress.

Greetings
Bernd
