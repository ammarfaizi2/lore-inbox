Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132263AbRAFBON>; Fri, 5 Jan 2001 20:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132487AbRAFBN5>; Fri, 5 Jan 2001 20:13:57 -0500
Received: from mail.texas.rr.com ([24.93.35.219]:19217 "EHLO sm5.texas.rr.com")
	by vger.kernel.org with ESMTP id <S132263AbRAFBNg>;
	Fri, 5 Jan 2001 20:13:36 -0500
Date: Fri, 5 Jan 2001 19:09:52 -0600 (CST)
From: Brad Hartin <bhartin@satx.rr.com>
To: Igmar Palsenberg <maillist@chello.nl>
cc: Tim Wright <timw@splhi.com>, Torrey Hoffman <torrey.hoffman@myrio.com>,
        Sven Koch <haegar@cut.de>,
        Kernel devel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
In-Reply-To: <Pine.LNX.4.21.0101060306210.6317-100000@server.serve.me.nl>
Message-ID: <Pine.LNX.4.21.0101051908100.12714-100000@osprey.hartinhome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2001, Igmar Palsenberg wrote:

> 
> > I had a similar situation except I was more interested in the performance
> > difference. Went from ~4MB/s with the 430HX controller to ~12.5MB/s with
> > the promise. This on an old Pentium system.
> 
> The network is 10 mbit, so 4 MB/sec is no good in this case.
> I've got the thing running, with (ibm)setmax. Don't hang the disk in a
> machine that does handle > 32 GB, because it will screw the limit the
> setmax just set.

If your network is 10 megaBIT, then 4 megaBYTES a second is sufficient to
saturate your network.  10Mbit maxes around 1.1Mbyte half duplex, or so.

Hell, my little server at home has a bunch of old SCSI-2 disks...they do a
whopping 120kbytes a second!

Brad Hartin


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
