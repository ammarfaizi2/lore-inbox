Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265049AbSJOWuK>; Tue, 15 Oct 2002 18:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264971AbSJOWtP>; Tue, 15 Oct 2002 18:49:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38161 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265049AbSJOWsr>; Tue, 15 Oct 2002 18:48:47 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: mapping 36 bit physical addresses into 32 bit virtual
Date: 15 Oct 2002 15:54:35 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aoi6bb$309$1@cesium.transmeta.com>
References: <20021015165947.50642.qmail@web13801.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20021015165947.50642.qmail@web13801.mail.yahoo.com>
By author:    Padraig O Mathuna <padraigo@yahoo.com>
In newsgroup: linux.dev.kernel
> 
> I'm developing some drivers for the AU1000 under
> Mountain Vista's 2.4.17 sherman release. The AU1000 is
> a MIPS based SOC with a 36 bit internal address bus
> and a 32 bit MIPS cpu.  According to the documentation
> the MIPS' TLB is able to map 32 bit virtual addresses
> to 36 bit physical addresses, however I cannot figure
> out how to get Linux to set this up.  I've looked at
> ioremap which only takes unsigned long (32bits) as an
> argument to assign a virtual address.  Is there
> another way?
> 

Oh no, the x86 madness is spreading!!!!

(It's depressing this happening on a MIPS system, which has been 64
bits since who-knows-when...)

*Vomit*

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
