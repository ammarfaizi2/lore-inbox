Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268285AbRHAVTz>; Wed, 1 Aug 2001 17:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268260AbRHAVTp>; Wed, 1 Aug 2001 17:19:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:3983 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S268285AbRHAVTk>;
	Wed, 1 Aug 2001 17:19:40 -0400
Date: Wed, 1 Aug 2001 17:19:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: alan@lxorguk.ukuu.org.uk, hch@caldera.de, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vxfs fix
In-Reply-To: <200108012103.VAA93890@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0108011716100.27494-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Aug 2001 Andries.Brouwer@cwi.nl wrote:

> When mount continues to try all types, it may try V7.
> That always succeeds, there is no test for magic or so,
> and after garbage has been mounted as a V7 filesystem,
> the kernel crashes or hangs or fails in other sad ways.
> Have not tried to debug.

That's interesting. IIRC, v7 has no magic in superblock. At all.
It shouldn't crash the box, though - I'll look into that.

