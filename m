Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVHLTan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVHLTan (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVHLTan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:30:43 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:944 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750756AbVHLTan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:30:43 -0400
Date: Fri, 12 Aug 2005 21:30:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Zachary Amsden <zach@vmware.com>
cc: Steven Rostedt <rostedt@goodmis.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Coywolf Qi Hunt <coywolf@gmail.com>, 7eggert@gmx.de,
       Ukil a <ukil_a@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Need help in understanding x86 syscall
In-Reply-To: <42FB91FA.7070104@vmware.com>
Message-ID: <Pine.LNX.4.61.0508122128260.16845@yvahk01.tjqt.qr>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz> 
 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com> 
 <1123770661.17269.59.camel@localhost.localdomain>  <2cd57c90050811081374d7c4ef@mail.gmail.com>
  <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com> 
 <1123775508.17269.64.camel@localhost.localdomain> 
 <1123777184.17269.67.camel@localhost.localdomain>  <2cd57c90050811093112a57982@mail.gmail.com>
  <2cd57c9005081109597b18cc54@mail.gmail.com>  <Pine.LNX.4.61.0508111310180.15153@chaos.analogic.com>
  <1123781187.17269.77.camel@localhost.localdomain>
 <1123781639.17269.83.camel@localhost.localdomain> <42FB91FA.7070104@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> zach-dev2:~ $ ldd /bin/ls
> linux-gate.so.1 =>  (0xffffe000)
>
> This is the vsyscall entry point, which gets linked by ld into all processes.

Just a clarification... not GNU ld (the binutils thing), but /lib/ld-linux.so

