Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281874AbRLDFeL>; Tue, 4 Dec 2001 00:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281857AbRLDFeC>; Tue, 4 Dec 2001 00:34:02 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:31877 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281844AbRLDFdx>;
	Tue, 4 Dec 2001 00:33:53 -0500
Date: Tue, 4 Dec 2001 00:33:50 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Mike Galbraith <mikeg@wen-online.de>
cc: "Udo A. Steinberg" <reality@delusion.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS]: Linux-2.5.1-pre5
In-Reply-To: <Pine.LNX.4.33.0112040617530.876-100000@mikeg.weiden.de>
Message-ID: <Pine.GSO.4.21.0112040032450.17686-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Dec 2001, Mike Galbraith wrote:

> On Mon, 3 Dec 2001, Udo A. Steinberg wrote:
> 
> > keyboard: Timeout - AT keyboard not present?(f4)
> > keyboard: Timeout - AT keyboard not present?(f4)
> 
> I see those too.  (the way it's written reminds me of a joke about silly
> MSDOS startup messages.. keyboard not detected, press F1 to continue:)

Revert changes in drivers/char/pc_keyb.c (or, better yet, entire BKL removal
from ->release() patch).

