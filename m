Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285745AbRLTA4T>; Wed, 19 Dec 2001 19:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285738AbRLTA4J>; Wed, 19 Dec 2001 19:56:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7431 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285730AbRLTAzy>; Wed, 19 Dec 2001 19:55:54 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: aio
Date: 19 Dec 2001 16:55:19 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9vrctn$bek$1@cesium.transmeta.com>
In-Reply-To: <E16Gjuw-0000UT-00@starship.berlin> <-0800> <20011219192136.F2034@redhat.com> <3C213270.966DABFE@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C213270.966DABFE@zip.com.au>
By author:    Andrew Morton <akpm@zip.com.au>
In newsgroup: linux.dev.kernel
> 
> The aio_* functions are part of POSIX and SUS, so merely reserving
> system call numbers for them does not seems a completely dumb
> thing to do, IMO.
> 

Yes, it is, unless you already have a design for how to map the aio_*
library functions onto system calls.

	-hpa


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
