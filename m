Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280623AbRKYB0l>; Sat, 24 Nov 2001 20:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280624AbRKYB0b>; Sat, 24 Nov 2001 20:26:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22028 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280623AbRKYB00>; Sat, 24 Nov 2001 20:26:26 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Journaling pointless with today's hard disks?
Date: 24 Nov 2001 17:25:53 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tphb1$n1m$1@cesium.transmeta.com>
In-Reply-To: <20011124174134.B4372@vega.ipal.net> <200111250024.AAA10086@mauve.demon.co.uk> <20011124185321.C4372@vega.ipal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011124185321.C4372@vega.ipal.net>
By author:    Phil Howard <phil-linux-kernel@ipal.net>
In newsgroup: linux.dev.kernel
> 
> By the time the seek completes, the speed is probably too slow to do a
> good write.  Options to deal with this include special handling for the
> emergency track to allow reading it back by intentionally slowing down
> the drive for that recovery.  Another option is flash disk.
> 

And yet another option is to dynamically adjust the data speed fed to
the head, to match the rotation speed of the platter.  This assumes
that the rotation speed can be measured, which should be trivial if
they use the rotation to power the drive electronics during shutdown.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
