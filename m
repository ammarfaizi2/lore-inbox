Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130320AbRBUX6V>; Wed, 21 Feb 2001 18:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130290AbRBUX6M>; Wed, 21 Feb 2001 18:58:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:21773 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129534AbRBUX5z>; Wed, 21 Feb 2001 18:57:55 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [rfc] Near-constant time directory index for Ext2
Date: 21 Feb 2001 15:57:46 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <971klq$vek$1@cesium.transmeta.com>
In-Reply-To: <E14VNAU-00014j-00@the-village.bc.nu> <20010221023515.6DF8E18C99@oscar.casa.dyndns.org> <971i36$180$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <971i36$180$1@penguin.transmeta.com>
By author:    torvalds@transmeta.com (Linus Torvalds)
In newsgroup: linux.dev.kernel
> 
> (The current VFS name hash is probably _really_ stupid - I think it's
> still my original one, and nobody probably ever even tried to run it
> through any testing.  For example, I bet that using a shift factor of 4
> is really bad, because it evenly divides a byte, which together with the
> xor means that you can really easily generate trivial bad cases). 
> 

Actually, the VFS name hash I think is derived from the "Dragon Book"
hash (via autofs), so it's not like it's completely untested.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
