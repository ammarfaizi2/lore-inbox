Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271321AbRHTQQY>; Mon, 20 Aug 2001 12:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271332AbRHTQQN>; Mon, 20 Aug 2001 12:16:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11529 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271321AbRHTQQJ>; Mon, 20 Aug 2001 12:16:09 -0400
Subject: Re: [PATCH] 2.4.9 Make thread group id visible in /proc/<pid>/status
To: dmccr@us.ibm.com (Dave McCracken)
Date: Mon, 20 Aug 2001 17:19:13 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <92830000.998321960@baldur> from "Dave McCracken" at Aug 20, 2001 10:39:20 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Yrlh-0006JF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This would make it easier to identify tasks that are part of a 
> multi-threaded process, at least for those that are using pthreads.  This 
> patch adds a TGid field to the status file.  This will not break ps, since 
> ps skips any field in status that it doesn't understand.

I didnt think anyone was using the broken tgid stuff ?
