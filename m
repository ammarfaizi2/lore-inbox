Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262651AbSI1AY1>; Fri, 27 Sep 2002 20:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262654AbSI1AY0>; Fri, 27 Sep 2002 20:24:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50696 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262651AbSI1AYZ>; Fri, 27 Sep 2002 20:24:25 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: sysrq on serial console
Date: 27 Sep 2002 17:29:42 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <an2t5m$rto$1@cesium.transmeta.com>
References: <3D94ED88.5040407@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3D94ED88.5040407@us.ibm.com>
By author:    Dave Hansen <haveblue@us.ibm.com>
In newsgroup: linux.dev.kernel
>
> Since the serial cleanups happened in 2.5, Magic Sysrq doesn't work 
> for me on the serial console.
> 

It's been broken for me in several 2.4 versions as well.  This is
highly troublesome.

> It looks like the UART_LSR_BI bit needs to be set in the status 
> variable for the break character to be interpreted as a break in the 
> driver.
> 
> I doubt that it is actually broken,  but it isn't immediately obvious 
> how that bit gets set.  Is there something that I should have set when 
> the device was initialized to make sure that UART_LSR_BI is asserted 
> in "status" when the interrupt occurs?
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
