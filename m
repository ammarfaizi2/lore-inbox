Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315855AbSEWL0Z>; Thu, 23 May 2002 07:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316456AbSEWL0Y>; Thu, 23 May 2002 07:26:24 -0400
Received: from mail.gmx.de ([213.165.64.20]:38123 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315855AbSEWL0X>;
	Thu, 23 May 2002 07:26:23 -0400
Message-ID: <3CECCF61.82AB0FF9@gmx.de>
Date: Thu, 23 May 2002 13:15:45 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
In-Reply-To: <E17Ajg8-0005mi-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> OS      Empty file      6 byte file             Pipe
>         Return  Size    Return  Size    Valid   Return  Size
> 
> AIX     EFAULT  99P     EFAULT  99P+6   99P+6   EFAULT  97P
> 
> Linux   99P     100P    99P-6   100P    99P-2   99P     99P
> (x86)
> 
> Solaris 98P     98P     99P-6   99P     99P     EFAULT  98.75P
> 

How could you miss this one - the only one that gets it right? ;-)

Linux2.0  EFAULT  0       EFAULT  6       0       EFAULT  0

SCNR, ET.
