Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293075AbSCFC2a>; Tue, 5 Mar 2002 21:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293078AbSCFC2U>; Tue, 5 Mar 2002 21:28:20 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:28136 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S293075AbSCFC2M>; Tue, 5 Mar 2002 21:28:12 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 5 Mar 2002 18:28:09 -0800
Message-Id: <200203060228.SAA06713@adam.yggdrasil.com>
To: sp@scali.com
Subject: Re: Does kmalloc always return address below 4GB?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Steffen Persvold <sp@scali.com>
[...]
>This is sort of the same question I have, the only problem you will
>have here is that vmalloc() will
>return only _virtual_ contiguous pages [...]

	In my example, you can assume the amount of memory
being allocated fits into a single page.  I was not talking
about issues related to crossing page boundaries.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
