Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130910AbRCFEVo>; Mon, 5 Mar 2001 23:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130911AbRCFEVe>; Mon, 5 Mar 2001 23:21:34 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:38928 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S130910AbRCFEV3>;
	Mon, 5 Mar 2001 23:21:29 -0500
Date: Tue, 6 Mar 2001 09:33:54 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: lkml <linux-kernel@vger.kernel.org>, kernelnewbies@humbolt.nl.linux.org
Subject: Re: sk_buff in 2.4.0
In-Reply-To: <200103060117.f261HDY404898@saturn.cs.uml.edu>
Message-ID: <Pine.SOL.3.96.1010306093004.4156A-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the patch by David S. Miller, copy_from_user() is still there (Line
14360 in zerocopy-2.4.0-1.diff). So which copy is reduced? Can anyone
explain kindly.

thanks
sourav

On Mon, 5 Mar 2001, Albert D. Cahalan wrote:

> > 	My question is: Is the state of the art same in 2.4.0, ie. is
> > protocol header and data still has to reside contiguously? Or header and
> > data may be non-contiguous and the driver does scatter/gather.
> > 
> > 	I am starting off in 2.4.0 , plz. help.
> 
> See the zero-copy patches by David S. Miller on ftp.kernel.org in
> his personal directory. If I remember right, the name of the
> directory is: /pub/linux/kernel/people/davem
> 
> These patches are now in Alan Cox's patch sets. (the "ac" kernels)
n> You may find Alan Cox's stuff in his personal directory ("alan") at
> the same FTP site.
> 

