Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280422AbRJaTGZ>; Wed, 31 Oct 2001 14:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280423AbRJaTGP>; Wed, 31 Oct 2001 14:06:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64272 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280422AbRJaTGG>; Wed, 31 Oct 2001 14:06:06 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: current->addr_limit
Date: 31 Oct 2001 11:06:28 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9rpi3k$6hq$1@cesium.transmeta.com>
In-Reply-To: <20011031143159.0bdc0981.vdinh@irisa.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011031143159.0bdc0981.vdinh@irisa.fr>
By author:    DINH Viet Hoa <Viet-Hoa.Dinh@irisa.fr>
In newsgroup: linux.dev.kernel
>
> When changing current->addr_limit through the macros 
> get_fs() and set_fs() in the kernel or in a kernel thread,
> do we need to lock anything to prevent anything else
> from accessing our custom value of current->addr_limit ?
> 

No, the currently running process owns "current".

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
