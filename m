Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTIJLOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 07:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTIJLOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 07:14:53 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:12210 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262001AbTIJLOw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 07:14:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Kernel-janitors] [PATCH] Remove modules.txt
Date: Wed, 10 Sep 2003 13:14:41 +0200
User-Agent: KMail/1.5.1
Cc: kernel-janitors@osdl.org
References: <20030910075240.F17CB2C75C@lists.samba.org>
In-Reply-To: <20030910075240.F17CB2C75C@lists.samba.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309101314.41460.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 September 2003 09:45, Rusty Russell wrote:
> modules.txt contains mainly ancient information which is replicated
> in the kconfig help message, README, makefile.txt or the modprobe manual
> page.  

I found another such gem in Documentation/smp.tex, which was last updated
more than five years ago. Favorite quote:

 "A single lock is maintained across all processors. This lock is
  required to access the kernel space."

The whole file has only historic value and should probably be removed
or have a comment that it does not apply to the current code.


	Arnd <><
