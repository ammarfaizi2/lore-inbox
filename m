Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275709AbRJNQOe>; Sun, 14 Oct 2001 12:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275719AbRJNQOY>; Sun, 14 Oct 2001 12:14:24 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:56466 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S275716AbRJNQLy>; Sun, 14 Oct 2001 12:11:54 -0400
Date: Sun, 14 Oct 2001 19:12:19 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mount --bind and -o [re: nosuid/noexec/nodev handling]
Message-ID: <20011014191218.Q1074@niksula.cs.hut.fi>
In-Reply-To: <20011014185908.P1074@niksula.cs.hut.fi> <Pine.GSO.4.21.0110141201540.6026-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0110141201540.6026-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Oct 14, 2001 at 12:06:02PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2001 at 12:06:02PM -0400, you [Alexander Viro] claimed:
> 
> 
> On Sun, 14 Oct 2001, Ville Herva wrote:
> 
> > Ummh, is there a reason for this behaviour?
> > 
> > $ mount --bind -o noexec /bin /home/sftp/bin
> 
> Broken - mount --bind ignores flags.  Create a binding, then remount it.
> IOW, two mount(2) calls are needed.

Ok.

And -o ro does not work with --bind at all, am I correct?

BTW, I just managed get a mount process to unkillable (-9) state while
playing with --bind. You might be uninterested in details if I can figure
out how to reproduce it?

 
-- v --

v@iki.fi
