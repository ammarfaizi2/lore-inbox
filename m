Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277699AbRJICZZ>; Mon, 8 Oct 2001 22:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277705AbRJICZP>; Mon, 8 Oct 2001 22:25:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26379 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277699AbRJICZA>; Mon, 8 Oct 2001 22:25:00 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] dead keys in unicode console mode
Date: 8 Oct 2001 19:25:15 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ptn6b$5eb$1@cesium.transmeta.com>
In-Reply-To: <20011008215313.A11879@melkor.dnp.fmph.uniba.sk> <20011009041618.A6135@win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011009041618.A6135@win.tue.nl>
By author:    Guest section DW <dwguest@win.tue.nl>
In newsgroup: linux.dev.kernel
> 
> If you want to do something like this, a new ioctl and a new
> structure are necessary. If you design something new, keep
> examples like Vietnamese in mind (with several accents on
> one symbol). We do support that now in the 8-bit world,
> but complete support of the 16-bit world still requires
> some work. (And in the meantime Unicode has already gone beyond.)
> 

Absolutely; under no circumstances should any further 16-bit
interfaces be created.  We should expect to have to expand into the
full 31-bit Unicode space.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
