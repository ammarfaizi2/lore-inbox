Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130663AbRCITrM>; Fri, 9 Mar 2001 14:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130666AbRCITrD>; Fri, 9 Mar 2001 14:47:03 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:44165 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S130662AbRCITqp>;
	Fri, 9 Mar 2001 14:46:45 -0500
Date: Fri, 9 Mar 2001 20:45:51 +0100
From: David Weinehall <tao@acc.umu.se>
To: Andries.Brouwer@cwi.nl
Cc: mikeg@wen-online.de, viro@math.psu.edu, aeb@veritas.com,
        linux-kernel@vger.kernel.org, root@chaos.analogic.com
Subject: Re: Ramdisk (and other) problems with 2.4.2
Message-ID: <20010309204551.B17813@khan.acc.umu.se>
In-Reply-To: <UTC200103091923.UAA144612.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <UTC200103091923.UAA144612.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Mar 09, 2001 at 08:23:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2001 at 08:23:43PM +0100, Andries.Brouwer@cwi.nl wrote:
> > Andries, comments?
> 
> > remount
> >    Attempt  to  change the mount flags of
> >    already-mounted file system.  This is commonly
> >    used to make a readonly file system writeable.
> 
> Yes. But maybe "mount flags" is too narrow?
> It is up to the filesystem what precisely it does.
> What about
> 
> remount
>         Attempt to remount an  already-mounted  file
>         system.  This is commonly used to change the
>         mount flags for a file system, especially to
>         make  a  readonly  file system writeable. It
>         does not change device or mount point.

Why not emphasize the last sentence, and write

"It cannot change device or mount point." instead.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
