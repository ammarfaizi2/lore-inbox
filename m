Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284652AbRLZRxM>; Wed, 26 Dec 2001 12:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284662AbRLZRxD>; Wed, 26 Dec 2001 12:53:03 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:4018 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S284652AbRLZRw5>;
	Wed, 26 Dec 2001 12:52:57 -0500
Date: Wed, 26 Dec 2001 12:52:56 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre2 forces ramfs on
Message-ID: <20011226125256.A19293@havoc.gtf.org>
In-Reply-To: <20011226122044.A7125@havoc.gtf.org> <Pine.GSO.4.21.0112261228180.2716-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0112261228180.2716-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Dec 26, 2001 at 12:36:09PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2001 at 12:36:09PM -0500, Alexander Viro wrote:
> What's more, quite a few ramfs methods are good candidates for library
> functions, since they are already shared with other filesystems and
> number of such cases is going to grow.

Good point, ext2meta uses the ramfs aops...

	Jeff


