Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVCHAcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVCHAcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 19:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVCHAcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 19:32:07 -0500
Received: from quechua.inka.de ([193.197.184.2]:24462 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262002AbVCHAbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 19:31:40 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [MC] [CHECKER] Do ext2, jfs and reiserfs respect mount -o sync/dirsync option?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <Pine.GSO.4.44.0503041440030.17155-100000@elaine24.Stanford.EDU>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1D8SdK-0003B4-00@calista.eckenfels.6bone.ka-ip.net>
Date: Tue, 08 Mar 2005 01:31:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.44.0503041440030.17155-100000@elaine24.Stanford.EDU> you wrote:
> 3. I open a file w/o O_SYNC, issue a bunch of writes, then call
> ioctl(FIOASYNC) to set the fd sync, then issure a second set of writes.
> Only the second set of writes are synchronous?

I also am curious if one can open a file, write to it, close it, open it and
do fsync()/fdatasync() on it?

Greetings
Bernd
