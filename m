Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289568AbSAVXf4>; Tue, 22 Jan 2002 18:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289564AbSAVXfg>; Tue, 22 Jan 2002 18:35:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43783 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289566AbSAVXfS>; Tue, 22 Jan 2002 18:35:18 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Console output for debugging
Date: 22 Jan 2002 15:34:45 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a2ksul$6v5$1@cesium.transmeta.com>
In-Reply-To: <3C4DF2AD.66BC3F6C@cicese.mx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C4DF2AD.66BC3F6C@cicese.mx>
By author:    Serguei Miridonov <mirsev@cicese.mx>
In newsgroup: linux.dev.kernel
>
> Q: Is there any function in the kernel which I can call
> safely from a module to print debug message on the console
> screen?
> 
> I don't want to use printk for some reasons. One of them is
> that I want messages to appear on the screen immediately,
> even from interrupt processing routines. Another is to be
> able to see messages until the system freezes completely in
> case of software or hardware bug.
> 

Use printk.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
