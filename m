Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276075AbRJOGxW>; Mon, 15 Oct 2001 02:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275841AbRJOGxM>; Mon, 15 Oct 2001 02:53:12 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:5801 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S276075AbRJOGxA>; Mon, 15 Oct 2001 02:53:00 -0400
Date: Mon, 15 Oct 2001 09:53:24 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Alexander Viro <viro@math.psu.edu>
Cc: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org,
        debian-devel@lists.debian.org
Subject: Re: mount --bind and -o [re: nosuid/noexec/nodev handling]
Message-ID: <20011015095323.T22640@niksula.cs.hut.fi>
In-Reply-To: <E15suoi-0006JL-00@calista.inka.de> <Pine.GSO.4.21.0110141942100.7054-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0110141942100.7054-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Oct 14, 2001 at 07:48:56PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 15 Oct 2001, Bernd Eckenfels wrote:
> 
> > In article <20011014185908.P1074@niksula.cs.hut.fi> you wrote:
> > >> mount --bind /home/luser /home/luser
> > >> mount -o remount,noexec /home/luser
> > 
> > Thats nice! For example on Debian GNU/Linux one can mount /var with noexec

Yes, it is very useful, and I keep finding new uses for it all the time.

Sadly, userspace support for it is not perfect; for example cp/rsync
--one-filesystem does not see --bind mount point as a filesystem boundary.


-- v --

v@iki.fi
