Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262967AbUKRUKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbUKRUKo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbUKRUIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:08:14 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:64921 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262964AbUKRUFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:05:18 -0500
To: torvalds@osdl.org
CC: hbryan@us.ibm.com, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
In-reply-to: <Pine.LNX.4.58.0411181140110.2222@ppc970.osdl.org> (message from
	Linus Torvalds on Thu, 18 Nov 2004 11:43:41 -0800 (PST))
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
 <E1CUquZ-0004Az-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411181027070.2222@ppc970.osdl.org>
 <E1CUrS0-0004Hi-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411181108140.2222@ppc970.osdl.org>
 <E1CUs2R-0004Nr-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411181140110.2222@ppc970.osdl.org>
Message-Id: <E1CUsWi-0004ST-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 18 Nov 2004 21:05:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's actually even _normal_ behaviour for many of the core users of shared 
> files. People who really do databases get quite upset if you don't let 
> them mmap as much memory as they want, because for them, they really tune 
> their cache sizes for the size of memory, and they think the OS (and 
> anything else, for that matter) just gets in their way. They want 99% of 
> memory to be used for the shared mapping, and the remaining 1% for their 
> code.

I'll try to write a FUSE deadlocker with the newly learnt info, and
let you know the result.

Thanks,
Miklos
