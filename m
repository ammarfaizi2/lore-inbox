Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311790AbSCNVMh>; Thu, 14 Mar 2002 16:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311791AbSCNVM1>; Thu, 14 Mar 2002 16:12:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59652 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311790AbSCNVMK>; Thu, 14 Mar 2002 16:12:10 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
Date: 14 Mar 2002 13:11:56 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6r3ms$88v$1@cesium.transmeta.com>
In-Reply-To: <a6qtb8$6fg$1@penguin.transmeta.com> <Pine.LNX.4.33.0203141234170.1286-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0203141234170.1286-100000@scsoftware.sc-software.com>
By author:    John Heil <kerndev@sc-software.com>
In newsgroup: linux.dev.kernel
> 
> No, the better/correct port is 0xED which removes the conflict.
> 
> We've used 0xED w/o problem doing an embedded linux implementation
> at kernel 2.4.1, where SMM issues were involved. (It was recommended
> to me by an x-Phoenix BIOS developer, because of its safety as well as
> conflict resolution,
> 

Sorry, causes breakage on quite a few machines.  I used it briefly in
SYSLINUX.  Phoenix doesn't have that issue since they're part of the
platform, so they can make it a requirement for their BIOS.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
