Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <161052-221>; Mon, 22 Mar 1999 16:25:40 -0500
Received: by vger.rutgers.edu id <160030-221>; Mon, 22 Mar 1999 16:25:25 -0500
Received: from gap.cco.caltech.edu ([131.215.139.43]:57433 "EHLO gap.cco.caltech.edu" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <157550-221>; Mon, 22 Mar 1999 16:25:09 -0500
To: mlist-linux-kernel@nntp-server.caltech.edu
Path: news
From: Stuart Anderson <sba@srl.caltech.edu>
Newsgroups: mlist.linux.kernel
Subject: Re: Knfsd and 2.2.3ac3 kernel status and problems
Date: Mon, 22 Mar 1999 12:56:04 -0800
Organization: California Institute of Technology, Pasadena
Message-ID: <36F6AE64.28799A1D@srl.caltech.edu>
References: <linux.kernel.Pine.LNX.3.96.990322212229.26078B-100000@naomi.fe.up.pt>
NNTP-Posting-Host: thrym.srl.caltech.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: Mozilla 4.5 [en] (X11; I; SunOS 5.6 sun4u)
X-Accept-Language: en
Sender: owner-linux-kernel@vger.rutgers.edu

Test account wrote:

>    Hello! Ive tested kernel 2.2.3 with ac3 patches from Alan Cox as a nfs
> server for SGI & IBM Aix workstations. I found some problems that you may
> recognize or not.
>
>    a) A little offtopic. Knfsd 1.2 doesnt compile in a Redhat 5.2
> installation with upgrades to kernel 2.2.3 and some packages, following
> Redhats document on the subject. I resorted to getting
> knfsd-981204-3.i386.rpm and knfsd-clients-981204-3.i386.rpm from
> Startbuck.  I also upgraded to glibc-2.1-0.990311.i386.rpm from the same
> Startbuck distribution. (Btw, does anyone have a binary rpm package for
> Knfsd 1.2?)
>

You may have run into the same problem I had with the configure script for
knfsd-1.2
having problems finding cpp. My solution was:

ln -s /usr/lib/gcc-lib/i686-pc-linux-gnu/egcs-2.91.66/cpp /lib

--
Stuart Anderson  sba@srl.caltech.edu  http://www.srl.caltech.edu/personnel/sba




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
