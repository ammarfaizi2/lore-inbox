Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287558AbSAEG5U>; Sat, 5 Jan 2002 01:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287565AbSAEG5K>; Sat, 5 Jan 2002 01:57:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64773 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287558AbSAEG44>; Sat, 5 Jan 2002 01:56:56 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ISA slot detection on PCI systems?
Date: 4 Jan 2002 22:56:34 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a16832$p7f$1@cesium.transmeta.com>
In-Reply-To: <20020102164757.A16976@thyrsus.com> <Pine.LNX.4.33.0201022305090.427-100000@Appserv.suse.de> <20020102170833.A17655@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020102170833.A17655@thyrsus.com>
By author:    "Eric S. Raymond" <esr@thyrsus.com>
In newsgroup: linux.dev.kernel
> 
> But this is not a bad reason.  Allowing people to avoid running suid 
> programs is a *good* reason.
> 

In this case that is a nonsense reason, since what you're proposing
doing is to change a userspace setuid program (which, on Unix, is
functionally a privilege level between the kernel and normal userspace
code) into kernel code.  Not a win.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
