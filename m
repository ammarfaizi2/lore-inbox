Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262843AbUKRSmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbUKRSmH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbUKRSlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:41:07 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:40681 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262856AbUKRSeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:34:12 -0500
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, hbryan@us.ibm.com, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@ucw.cz
In-Reply-To: <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
	 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100798975.6018.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 18 Nov 2004 17:29:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I really do believe that user-space filesystems have problems. There's a 
> reason we tend to do them in kernel space. 
> 
> But limiting the outstanding writes some way may at least hide the thing.

Possibly dumb question. Is there a reason we can't have a prctl() that
flips the PF_* flags for a user space daemon in the same way as we do
for kernel threads that do I/O processing ?

