Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311819AbSCNV6l>; Thu, 14 Mar 2002 16:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311818AbSCNV6c>; Thu, 14 Mar 2002 16:58:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11527 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311819AbSCNV6W>; Thu, 14 Mar 2002 16:58:22 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
Date: 14 Mar 2002 13:57:40 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6r6ck$8ia$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0203141234170.1286-100000@scsoftware.sc-software.com> <Pine.LNX.4.33.0203141318130.9855-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0203141318130.9855-100000@penguin.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> Port ED is fine for a BIOS, which (by definition) knows what the
> motherboard devices are, and thus knows that ED cannot be used by
> anything.
> 
> But it _is_ an unused port, and that's exactly the kind of thing that
> might be used sometime in the future. Remember the port 22/23 brouhaha
> with Cyrix using it for their stuff, and later Intel getting into the fray
> too?
> 
> So the fact that ED works doesn't mean that _stays_ working.
> 

It is, in fact, broken on several systems -- I tried ED in SYSLINUX
for a while, and it broke things for people.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
