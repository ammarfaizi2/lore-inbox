Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129547AbQKHS3d>; Wed, 8 Nov 2000 13:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129527AbQKHS3X>; Wed, 8 Nov 2000 13:29:23 -0500
Received: from kanga.kvack.org ([216.129.200.3]:22542 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S129508AbQKHS3O>;
	Wed, 8 Nov 2000 13:29:14 -0500
Date: Wed, 8 Nov 2000 13:27:36 -0500 (EST)
From: <kernel@kvack.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Brian Pomerantz <bapper@piratehaven.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Pentium 4 and 2.4/2.5
In-Reply-To: <E13tZrA-0000HQ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1001108132530.8587A-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2000, Alan Cox wrote:

> What state does it leave the condition codes ?  That matters. 

Alan, rep ; nop is one of the suggested 2 byte fillers in the Athon
optimization guide; it's handled during instruction decode and is
completely free.  It also has no effect on K6s.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
