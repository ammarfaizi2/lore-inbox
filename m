Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTEXM07 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 08:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264089AbTEXM07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 08:26:59 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:44256 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262429AbTEXM06
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 08:26:58 -0400
Date: Sat, 24 May 2003 14:39:28 +0200 (CEST)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.s-tec.de
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Defective Disk not reported as Dead
In-Reply-To: <200305230739.h4N7d2u22467@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.55.0305241432410.24000@omega.s-tec.de>
References: <Pine.LNX.4.55.0305230911560.18618@omega.s-tec.de>
 <200305230739.h4N7d2u22467@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.9; AVE: 6.19.0.3; VDF: 6.19.0.20; host: email)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

you should understand, that I really try not to reproduce the Problem,
since this is a VERY productive Database- and Fileserver.

So am seeking hints on known Bugs or just some hints.

For the Kernel-traces I assume that I would need some messages.
But for the kernel everything seems to be normal. At least there are
no messages in syslog.

Oktay

On Fri, 23 May 2003, Denis Vlasenko wrote:

> On 23 May 2003 10:23, Oktay Akbal wrote:
> > Hello !
> >
> > We do have some strange problem here.
> > A Server with some qlogic qla2002f-Adapter (2-channel)is connected to
> > 2 external Raid-Arrays via multipathing and raid1 on top of it. But
> > the multipathing and raid should not be the problem here.
> >
> > The Raid-Arrays itself are Fibre-to-Ide and present themselfs as 1
> > disks each. Now for the problem: Due to a firmware bug the raid-boxes
> > sometimes seems to loose the ability to write (and read i think) to
> > their internal disks. The effect is, that the cache fills up but does
> > not get flushed to disks. When full, the box is in a strange state.
> > It gets detected when reloading the kernel-modules but linux can no
> > longer access the disks. when accessing the partition all processes
> > on that disk hang (like ls or ps -efa etc.)
>
> This sounds like bug. Can you determine where exactly those processes
> are nailed? I bet you'll see them in D state, but folks will need
> more details, more precisely kernel stack backtraces.

