Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272887AbTG3OLD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272888AbTG3OLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:11:02 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:54543 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S272887AbTG3OJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:09:55 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Margit Schubert-While <margitsw@t-online.de>
Subject: Re: Linux 2.4.22-pre9
Date: Wed, 30 Jul 2003 16:08:29 +0200
User-Agent: KMail/1.5.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       viro@math.psu.edu
References: <5.1.0.14.2.20030730080726.00a797e0@pop.t-online.de> <1059573029.8051.4.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1059573029.8051.4.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307301608.29561.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 July 2003 15:58, Alan Cox wrote:

Hi Alan,

> On Mer, 2003-07-30 at 07:08, Margit Schubert-While wrote:
> > if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.22-pre9;
> > fi depmod: *** Unresolved symbols in
> > /lib/modules/2.4.22-pre9/kernel/drivers/net/wan/comx.o
> > depmod:         proc_get_inode
> >
> > Still not fixed :-)
> You still haven't sent a patch to fix it 8)
well, I sent a "fix" which isn't a fix. We all agree, hch, viro etc.

Al: You said you have a fix which rips out the offending totally wrong code?

ciao, Marc

