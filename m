Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277020AbRJDXY2>; Thu, 4 Oct 2001 19:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277203AbRJDXYS>; Thu, 4 Oct 2001 19:24:18 -0400
Received: from quechua.inka.de ([212.227.14.2]:14146 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S277020AbRJDXYI>;
	Thu, 4 Oct 2001 19:24:08 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: bad blocks and rebooting
In-Reply-To: <20011003134423.A28512@home.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.10-xfs (i686))
Message-Id: <E15pHqe-00048A-00@calista.inka.de>
Date: Fri, 05 Oct 2001 01:24:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011003134423.A28512@home.com> you wrote:
> I have a system setup as a black box. If the system is powered
> off accidentally, and upon powering on the system keeps rebooting 
> after trying to do the file system consistency check. The file 
> system message is to run "ef2fsck -v -y <partition>. Is there
> anyway to force this check at lilo prompt? 

You can modify the init scripts to search for an init arg. Most init scripts
check for /forchecheck. For an embedded box it is MUCH better to have the
filesystem readonly or at least use a journaled FS.

Greetings
Bernd
