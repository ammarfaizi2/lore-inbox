Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289692AbSAOWKE>; Tue, 15 Jan 2002 17:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289697AbSAOWJy>; Tue, 15 Jan 2002 17:09:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11021 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289692AbSAOWJv>; Tue, 15 Jan 2002 17:09:51 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 3.5G user space speed
Date: 15 Jan 2002 14:09:28 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a229ao$9j9$1@cesium.transmeta.com>
In-Reply-To: <16247691406.20020115234737@spylog.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <16247691406.20020115234737@spylog.ru>
By author:    Peter Zaitsev <pz@spylog.ru>
In newsgroup: linux.dev.kernel
> 
>   2.4.xaa Series as well as  SuSE kernels have  3.5G userspace option,
>   which seems to be quite useful, therefore I see it's not included
>   is stock kernel for some reasons. Also I've heard this
>   configuration may have some performance problems.
> 

Be careful... 3.5G breaks the initrd protocol (assuming you have
enough RAM for it to matter anyway), unless you have a 2.03 boot
protocol capable (a) kernel and (b) bootloader.  At this point I don't
know of any bootloader other than SYSLINUX 1.65 or later that is 2.03
compatible.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
