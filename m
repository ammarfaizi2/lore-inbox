Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264846AbRFUFll>; Thu, 21 Jun 2001 01:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264847AbRFUFlb>; Thu, 21 Jun 2001 01:41:31 -0400
Received: from quechua.inka.de ([212.227.14.2]:11788 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S264846AbRFUFlX>;
	Thu, 21 Jun 2001 01:41:23 -0400
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: harddisk support
In-Reply-To: <CA256A72.001BA0E4.00@d73mta01.au.ibm.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E15CxDY-0005xT-00@sites.inka.de>
Date: Thu, 21 Jun 2001 07:41:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <CA256A72.001BA0E4.00@d73mta01.au.ibm.com> you wrote:
> How can I access more than 16 harddisks?
Create the Device File with:

cd /dev ; MAKEDEV sdq
-or-
cd /dev ; mknod sdq b 65 0
mknod sdq1 b 65 1
...
