Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285691AbRLHACa>; Fri, 7 Dec 2001 19:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285693AbRLHACP>; Fri, 7 Dec 2001 19:02:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57105 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285691AbRLHAB6>; Fri, 7 Dec 2001 19:01:58 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: highmem question
Date: 7 Dec 2001 16:01:33 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9url8t$nmo$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0112071404280.29154-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.30.0112071404280.29154-100000@mustard.heime.net>
By author:    Roy Sigurd Karlsbakk <roy@karlsbakk.net>
In newsgroup: linux.dev.kernel
> 
> I heard that himem slows down systems.

It does, because it's a hack to extend 32-bit machines beyond their
architectural lifetime.

> - How much memory can Linux use without highmem enabled? (I've heard it's
>   1GB, but Linux found 1,2GB without ...)

On i386, it supports 896 MB without HIGHMEM.

> - How much is a system slowed down?

Depends completely on your application mix and amount of RAM -- and
whether or not you're using 4G or 64G HIGHMEM, the latter being more
severe across a whole bunch of axes.

> - How can this be fixed? I've heard it's a PCI issue (stuff being memory
>   mapped above the 2GB limit?)

Go to a 64-bit CPU architecture.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
