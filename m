Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267868AbUHUVAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267868AbUHUVAO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 17:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267880AbUHUU5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:57:45 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:51673 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267868AbUHUU5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:57:03 -0400
Subject: Re: Problems compiling kernel modules
From: Lee Revell <rlrevell@joe-job.com>
To: Lei Yang <leiyang@nec-labs.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4127B49A.6080305@nec-labs.com>
References: <4127A15C.1010905@nec-labs.com>
	 <20040821214402.GA7266@mars.ravnborg.org> <4127A662.2090708@nec-labs.com>
	 <20040821215055.GB7266@mars.ravnborg.org>  <4127B49A.6080305@nec-labs.com>
Content-Type: text/plain
Message-Id: <1093121824.854.167.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 Aug 2004 16:57:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-21 at 16:46, Lei Yang wrote:
> What about multi-file module?
> 
> Say test.c doesn't include stdio.h, while there is some other .c file 
> which is to be compiled and linked into test.ko, include stdio?
> 
> Would that work?
> 

Are you just trying to print from a kernel module?  Use printk.

The kernel does not really have its own standard input and standard
output - the kernel manages those things for processes.

Lee

