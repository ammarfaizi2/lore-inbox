Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSHXAPn>; Fri, 23 Aug 2002 20:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSHXAPn>; Fri, 23 Aug 2002 20:15:43 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:50913 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314459AbSHXAPm>; Fri, 23 Aug 2002 20:15:42 -0400
Date: Fri, 23 Aug 2002 19:19:51 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Daniel I. Applebaum" <kernel@danapple.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 build failure
In-Reply-To: <20020823230706.61F8F10B54@wotke.danapple.com>
Message-ID: <Pine.LNX.4.44.0208231914080.22497-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2002, Daniel I. Applebaum wrote:

> I get the following error when trying to build 2.5.31:
> gcc -Wp,-MD,./.entry.o.d -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux-2.5.31/include -nostdinc -iwithprefix include  -traditional  -c -o entry.o entry.S
> /usr/lib/gcc-lib/i386-redhat-linux/2.96/tradcpp0: Usage: /usr/lib/gcc-lib/i386-redhat-linux/2.96/tradcpp0 [switches] input output
> make[2]: *** [entry.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.5.31/arch/i386/kernel'
> make[1]: *** [arch/i386/kernel] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.31'
> make: *** [bzImage] Error 2

The best explanation I have for this is a buggy compiler - I think I've 
seen one report like this before. What exact version are you using?

gcc -v 
rpm -qa | grep gcc

--Kai


