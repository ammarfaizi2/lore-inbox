Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270436AbRHNEfW>; Tue, 14 Aug 2001 00:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270439AbRHNEfM>; Tue, 14 Aug 2001 00:35:12 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:1245 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270436AbRHNEfG>;
	Tue, 14 Aug 2001 00:35:06 -0400
Date: Tue, 14 Aug 2001 00:35:18 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (1/11) fs/super.c fixes
In-Reply-To: <Pine.GSO.4.21.0108140023480.10579-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0108140033100.10579-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Aug 2001, Alexander Viro wrote:
 
> Cleanup: we move decrementing ->s_active into put_super(). Callers updated.

... and that line in description is also bogus, indeed (same reasons -
description from 11/11). Self-LART applied...

