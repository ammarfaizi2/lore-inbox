Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285094AbRLRUhy>; Tue, 18 Dec 2001 15:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285138AbRLRUhn>; Tue, 18 Dec 2001 15:37:43 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14857 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285117AbRLRUfk>; Tue, 18 Dec 2001 15:35:40 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: 18 Dec 2001 12:35:31 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9vo9aj$j2e$1@cesium.transmeta.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D804@orsmsx111.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <59885C5E3098D511AD690002A5072D3C42D804@orsmsx111.jf.intel.com>
By author:    "Grover, Andrew" <andrew.grover@intel.com>
In newsgroup: linux.dev.kernel
> 
> Implicit in the use of initrd is that you have to *make a ramdisk image*,
> and then tell your bootloader to load it. If you have a bootloader that can
> load multiple images (i.e. the modules themselves) you can skip the first
> step.
> 

initramfs will do this just fine.

> Again, even the new scheme will still involve the creation of an initrd. I'm
> saying, as a user, it would be easier for me to not do this, and just modify
> a .conf file to have the driver loaded early-on.

See above.

> I'm not arguing that the new initrd won't be better than the old initrd
> (because obviously you are right) I'm arguing that no matter how whizzy
> initrd is, it's still an unnecessary step, and it's one that other OSs (e.g.
> FreeBSD) omit in favor of the approach I'm advocating.

Doing things in multiple steps is often appropriate.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
