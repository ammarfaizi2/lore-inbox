Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSHPIb5>; Fri, 16 Aug 2002 04:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSHPIb5>; Fri, 16 Aug 2002 04:31:57 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:25619 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S317081AbSHPIb4>; Fri, 16 Aug 2002 04:31:56 -0400
Message-Id: <200208160831.g7G8Uxp24080@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Richard Zidlicky <rz@linux-m68k.org>, Scorpion <scorpionlab@ieg.com.br>
Subject: Re: Flush issues in boot phase
Date: Fri, 16 Aug 2002 11:27:50 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200208131425.19328.scorpionlab@ieg.com.br> <20020815121334.A1940@linux-m68k.org>
In-Reply-To: <20020815121334.A1940@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 August 2002 08:13, Richard Zidlicky wrote:
> On Tue, Aug 13, 2002 at 02:25:19PM -0300, Scorpion wrote:
> > Hi fellows,
> > I'm still trying to boot my dual AMD 1800XP machines (not MP).
> > I got one more step disabling MP 1.4 support on BIOS setup, but now
> > (using 2.4.19 kernel) I have a more general question.
> > The boot phase stop exactly with the message:
> >
> > Partition check:
> > hda:
> >
> > Should I consider that the kernel stop exactly in this point
>
> it stops exactly between this printk and the next (unreached) one.
>
> See fs/partitions, probably read_dev_sector hangs so put printk's
> around that.

Does it works with one CPU taken out?
--
vda
