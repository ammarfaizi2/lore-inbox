Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbTEWJVW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 05:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263985AbTEWJVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 05:21:22 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:6819 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id S263983AbTEWJVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 05:21:19 -0400
Importance: Normal
Sensitivity: 
Subject: Re: Patch to add SysRq handling to 3270 console
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF52A877A4.CB4F43A8-ONC1256D2F.00336EBB@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Fri, 23 May 2003 11:30:38 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 23/05/2003 11:31:35
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Christoph,

> What is the z990 code drop?  Can you please merge support for new
> hardware into mainline instead of realsing it in these silly IBM
> patchkits for old kernels with exploitable security issues..

The z990 is the official name for the new mainframe machine. The z990
code drop contains the changes & new features for the new machine. The
IBM process forces us to publish the new features patches on developer
works first before we can think about integration into the mainline.
You may not like it but this is a restriction we as the s390 team at
IBM have to live with.

> Btw, what's the state of 2.4.21-rc3 vs s390(x)?
No too good. It basically works but there is a big bunch of patches
missing. I sent them to Marcelo for integration a few weeks ago but
to me Marcelo is a black hole. Never heard anything about it, not
even a "no". I sent Alan a copy of the patches adapted to his -ac
tree. He accepted most of it into rc2-ac2.

blue skies,
   Martin


