Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTL1XF1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 18:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbTL1XF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 18:05:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61969 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262127AbTL1XFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 18:05:20 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
Date: 28 Dec 2003 15:05:13 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bsnnj9$lkf$1@cesium.transmeta.com>
References: <20031228180424.GA16622@mail-infomine.ucr.edu> <Pine.LNX.4.44.0312281032350.21070-100000@twin.uoregon.edu> <20031228213535.GA21459@mail-infomine.ucr.edu> <1072647938.10298.3.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1072647938.10298.3.camel@laptop.fenrus.com>
By author:    Arjan van de Ven <arjanv@redhat.com>
In newsgroup: linux.dev.kernel
> 
> On Sun, 2003-12-28 at 22:35, Johannes Ruscheinski wrote:
> 
> > Fisrt of all: thanks for the advice Joel!  Two questions: why not use the
> > hardware raid capability of the Promise tx4000 and if we'd use software
> > raid instead, what would be the CPU overhead?
> 
> be careful, almost all ata raid controllers out there are *software
> raid* hidden in a binary only driver. Also generally the on-disk format
> of these is quite unfortionate resulting in slower access than linux
> software raid can do...
> 

Not to mention, well, *proprietary*.  Consider this: with Linux
swraid, you don't have to worry about your manufacturer discontinuing
your product or going out of business; as long as you can connect your
disks to a CPU using any kind of controller you can recover your
data.  If a proprietary RAID controller croaks, and you can't get
another one of the same brand/model, you might have no more data...

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
