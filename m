Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268873AbUI3F6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268873AbUI3F6v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 01:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268846AbUI3F6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 01:58:51 -0400
Received: from quechua.inka.de ([193.197.184.2]:62676 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S268873AbUI3F6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 01:58:49 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org, ishikawa@yk.rim.or.jp
Subject: Re: FSCK message suppressed during booting? (2.6.9-rc2)
Organization: Deban GNU/Linux Homesite
In-Reply-To: <415B5034.6060809@yk.rim.or.jp>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CCtxn-00075V-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 30 Sep 2004 07:58:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <415B5034.6060809@yk.rim.or.jp> you wrote:
> That is, under previous 2.4.xx kernel, I would have gotten
> "The disk was not unmounted cleanly. Running fsck." or
> some such message and fsck printed its
> progress bar using ASCII characters.

Well, this is not a kernel function, your Distribution is calling fsck in
the bootup scripts, and fsck is calling the filesystem specific
implementation and this is checking if fsck is needed.

If you do not get this messages anymore contact your linux distribution
provider.

Do you habe maybe a journalling filesystem? Or do you have set some flags to
force the skip of fsck (/fastboot)

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
