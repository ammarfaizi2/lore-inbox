Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263409AbRFFHv6>; Wed, 6 Jun 2001 03:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263411AbRFFHvt>; Wed, 6 Jun 2001 03:51:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22537 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263409AbRFFHve>; Wed, 6 Jun 2001 03:51:34 -0400
Subject: Re: SCSI is as SCSI don't...
To: alan@clueserver.org (Alan Olsen)
Date: Wed, 6 Jun 2001 08:49:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, laughing@shared-source.org (Alan Cox)
In-Reply-To: <Pine.LNX.4.10.10106052247210.17745-100000@clueserver.org> from "Alan Olsen" at Jun 05, 2001 11:08:04 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E157Y4j-0007yX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am trying to get 2.4.5 and/or 2.4.5-ac9 working.  Both are choking on
> compile with an odd error message or four...
> 
> In file included from /usr/src/linux-2.4.5-ac9/include/linux/raid/md.h:50,
>                  from ll_rw_blk.c:30:
> /usr/src/linux-2.4.5-ac9/include/linux/raid/md_k.h: In function
> `pers_to_level':/usr/src/linux-2.4.5-ac9/include/linux/raid/md_k.h:41:
> warning: control reaches end of non-void function

That is just a warning caused by a C compiler bug and harmless. The sg case
you report I've seen random variants of caused by burner bugs, software bugs
and scsi layer bugs - I dont know what it would be and you didnt give enough
info


