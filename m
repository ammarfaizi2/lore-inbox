Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283097AbRLWCK5>; Sat, 22 Dec 2001 21:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283223AbRLWCKu>; Sat, 22 Dec 2001 21:10:50 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:57037 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283097AbRLWCKf>;
	Sat, 22 Dec 2001 21:10:35 -0500
Date: Sat, 22 Dec 2001 21:10:33 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <a03cke$640$1@cesium.transmeta.com>
Message-ID: <Pine.GSO.4.21.0112222109050.21702-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 22 Dec 2001, H. Peter Anvin wrote:

> Followup to:  <E16Hwks-0001wV-00@schizo.psychosis.com>
> By author:    Dave Cinege <dcinege@psychosis.com>
> In newsgroup: linux.dev.kernel
> > 
> > Deja Vu: *shrug*  Your "all they have to do" is quite heavy.
> > (boot loader must implement full cpio/tar[/gzip}
> > 
> 
> cpio is trivial.  tar is a bit more painful, but not too bad.  gzip is
> unacceptable, but should not be required.

tar is ugly as hell and not going to be supported on the kernel side.

