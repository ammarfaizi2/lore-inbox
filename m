Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbSAPTLG>; Wed, 16 Jan 2002 14:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287276AbSAPTK5>; Wed, 16 Jan 2002 14:10:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286311AbSAPTKp>; Wed, 16 Jan 2002 14:10:45 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNC] Linld 0.94 available
Date: 16 Jan 2002 11:10:29 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a24j75$4fi$1@cesium.transmeta.com>
In-Reply-To: <200201160910.g0G9AdE10817@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200201160910.g0G9AdE10817@Port.imtp.ilyichevsk.odessa.ua>
By author:    Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
In newsgroup: linux.dev.kernel
> 
> I believe this workaround really should be placed in kernel:
> some day we will meet BIOS with same breakage!
> 

As I already explained to Denis in private email:

a) It's not "BIOS breakage"; it's standard behaviour for DOS'
   HIMEM.SYS.  LOADLIN must have dealt with it, I don't know through
   what exact method.

b) If we put this in the kernel, real systems will break.  This isn't
   a "maybe", it's a "definitely."

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
