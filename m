Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130471AbRDMMvH>; Fri, 13 Apr 2001 08:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130487AbRDMMu5>; Fri, 13 Apr 2001 08:50:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55051 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130471AbRDMMuv>; Fri, 13 Apr 2001 08:50:51 -0400
Subject: Re: Yacc in 2.4.3 causes kernel compile to fail (aicasm_gram.y)
To: dweekly@legato.com (David E. Weekly)
Date: Fri, 13 Apr 2001 13:51:33 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (ML-linux-kernel)
In-Reply-To: <061f01c0c3d8$c34e8870$5c044589@legato.com> from "David E. Weekly" at Apr 12, 2001 10:15:32 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14o331-0002nt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The Makefile system is expecting the YACC variable to be defined; a
> straightforward workaround is then to define:
> 
> export YACC="`which bison` -y"

Umm

[root@irongate linux.ac]# which yacc
/usr/bin/yacc
/usr/bin/which: no bison in (/usr/local/bin:/bin:/usr/bin:/usr/X11R6/bin:/usr/X11R6/bin)

so you would need to check for yacc first.
