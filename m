Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285935AbRLTDVW>; Wed, 19 Dec 2001 22:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285937AbRLTDVM>; Wed, 19 Dec 2001 22:21:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4108 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285935AbRLTDU7>; Wed, 19 Dec 2001 22:20:59 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Booting a modular kernel through a multiple streams file / Making Linux multiboot capable and grub loading kernel modules at boot time.
Date: 19 Dec 2001 19:20:47 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9vrlef$mat$1@cesium.transmeta.com>
In-Reply-To: <200112181605.KAA00820@tomcat.admin.navo.hpc.mil> <m18zbzwp34.fsf@frodo.biederman.org> <3C205FBC.60307@zytor.com> <m1zo4fursh.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m1zo4fursh.fsf@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
> 
> Which just goes to show what a fragile firmware design it is, to have
> firmware callbacks doing device I/O.  I think the whole approach of
> having firmware callbacks is fundamentally flawed but I'll do my best
> to keep it working, for those things that care.  If it works over 50%
> of the time I'm happy...
> 

NAK.  You can make it perfectly robust thankyouverymuch, as long as
you don't try to *mix* firmware and poking directly at the
hardware... this is a classic "who owns what" class problem.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
