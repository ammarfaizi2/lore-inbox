Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263061AbREWMRw>; Wed, 23 May 2001 08:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263063AbREWMRm>; Wed, 23 May 2001 08:17:42 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44041 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263061AbREWMRg>; Wed, 23 May 2001 08:17:36 -0400
Subject: Re: [PATCH] struct char_device
To: Andries.Brouwer@cwi.nl
Date: Wed, 23 May 2001 13:13:50 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org, viro@math.psu.edu
In-Reply-To: <UTC200105231157.NAA80659.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at May 23, 2001 01:57:20 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152XWQ-0003Wa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is entirely possible to remove all partition table handling code
> from the kernel. User space can figure out where the partitions
> are supposed to be and tell the kernel.
> For the initial boot this user space can be in an initrd,
> or it could just be a boot parameter: rootdev=/dev/hda,
> rootpartition:offset=N,length=L, rootfstype=ext3.

Not if you want compatibility.


