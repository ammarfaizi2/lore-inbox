Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277591AbRJREim>; Thu, 18 Oct 2001 00:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277592AbRJREic>; Thu, 18 Oct 2001 00:38:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27141 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277591AbRJREiU>; Thu, 18 Oct 2001 00:38:20 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "3.5GB user address space" option.
Date: 17 Oct 2001 21:38:35 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9qlmcb$4h4$1@cesium.transmeta.com>
In-Reply-To: <1981072193242.20011018021819@spylog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1981072193242.20011018021819@spylog.com>
By author:    "Oleg A. Yurlov" <kris@spylog.com>
In newsgroup: linux.dev.kernel
>
> 
>         Hi, folks,
> 
>         How  I  can  use  3.5GB  in my apps ? I try malloc() and get error on 2G
> bounce... :-(
> 
>         Hardware - SMP server, 2Gb RAM, 8Gb swap, kernel 2.4.12aa1.
> 

Get a 64-bit CPU.  You're running into a fundamental limit of 32-bit
architectures.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
