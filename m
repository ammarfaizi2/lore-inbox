Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317803AbSGVUEH>; Mon, 22 Jul 2002 16:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317804AbSGVUEH>; Mon, 22 Jul 2002 16:04:07 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:26097 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317803AbSGVUEE>; Mon, 22 Jul 2002 16:04:04 -0400
Subject: Re: Problems with AMD 768 IDE support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: Ernst Lehmann <lehmann@acheron.franken.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020722150712.11545A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1020722150712.11545A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 22:19:43 +0100
Message-Id: <1027372783.31787.77.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 20:13, Richard B. Johnson wrote:
> On 22 Jul 2002, Ernst Lehmann wrote:
> > Hi,
> > I have here a Dual-Athlon Box, with a AMD760MPX Chipset and AMD768 IDE.
> > 
> > In the base 2.4.18 kernel there seems to be no support for the
> > IDE-Chipset
> 
> It is supposed to be 'standard'. If you enable:
> 
> CONFIG_IDE=y
> CONFIG_BLK_DEV_MODES=y
> CONFIG_BLK_DEV_HD=y
> ... it should work. The amd74xx was seperate, it was a "Viper" chip-set.
> I believe that the newer AMD Chip-Sets are generic.

They are not generic, although they are fairly similar. You need the -ac
tree right now for the 760MP/MPX IDE, although the port wont be hard

