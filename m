Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285160AbRLMUfe>; Thu, 13 Dec 2001 15:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285161AbRLMUfY>; Thu, 13 Dec 2001 15:35:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57362 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285160AbRLMUfN>; Thu, 13 Dec 2001 15:35:13 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: User/kernelspace stuff to set/get kernel variables
Date: 13 Dec 2001 12:34:49 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9vb3d9$9jk$1@cesium.transmeta.com>
In-Reply-To: <20011213155532Z284289-18284+114@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011213155532Z284289-18284+114@vger.kernel.org>
By author:    DevilKin <devilkin@gmx.net>
In newsgroup: linux.dev.kernel
>
> Hello
> 
> I've been looking on the web, and couldn't really find what i would want...
> 
> Basically: is it possible to - one way or another - set variables at
> kernel boot and read those using userspace utilities?
> 

The entire kernel command line is quoted verbatim in /proc/cmdline.

Additionally, items of the form foo=bar that are not recognized by the
kernel become environment variables to init, and items not of that
form *sometimes* become command-line options to init...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
