Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290371AbSAXWFm>; Thu, 24 Jan 2002 17:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290379AbSAXWFc>; Thu, 24 Jan 2002 17:05:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7432 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290371AbSAXWFT>; Thu, 24 Jan 2002 17:05:19 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RFC: booleans and the kernel
Date: 24 Jan 2002 14:05:01 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a2q0ed$vqt$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0201241433110.2839-100000@waste.org> <Pine.LNX.3.95.1020124165419.1859A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.95.1020124165419.1859A-100000@chaos.analogic.com>
By author:    "Richard B. Johnson" <root@chaos.analogic.com>
In newsgroup: linux.dev.kernel
> 
> Don't you wish!
> 
> 	cmpl $0,8(%ebp)      <-------------- Compare against zero.

That's the fastest way in x86 to compare a memory variable against
zero.  andl %reg,%reg only works if the value is already in a
register.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
