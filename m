Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136148AbREJMdT>; Thu, 10 May 2001 08:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136149AbREJMdH>; Thu, 10 May 2001 08:33:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42255 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136148AbREJMcp>; Thu, 10 May 2001 08:32:45 -0400
Subject: Re: Linux thread problem
To: sachin_76@lycos.com
Date: Thu, 10 May 2001 13:36:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <NJMIGAKMNAMIKAAA@mailcity.com> from "sachin kitnawat" at May 10, 2001 02:19:41 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xpgb-0004hI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I am porting an Threading Application from Hp-UX 11.0 
> to Red Hat Linux 6.2. There is a system call pthread_condattr_setpshared 
> and pthread_mutex_setpshared in HP-UX which is not available on Linux.

They are actually library not system calls in Linux and may well not be
in earlier glibc. You might want to see if glibc2.2 has them. 

For Red Hat stuff there are Red Hat lists 
	http://www.redhat.com/mailing-lists

Alan

