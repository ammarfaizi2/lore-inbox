Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262301AbSJOCoY>; Mon, 14 Oct 2002 22:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbSJOCoY>; Mon, 14 Oct 2002 22:44:24 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:46025 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262301AbSJOCoV>; Mon, 14 Oct 2002 22:44:21 -0400
Subject: Re: Linux v2.5.42
To: dipankar@beaverton.ibm.com, Andrew Morton <akpm@zip.com.au>,
       Alan Cox <alan@redhat.com>, Jens Axboe <axboe@suse.de>,
       Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFA3F4BE8A.D4A810ED-ON88256C53.000F3D3B@boulder.ibm.com>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Mon, 14 Oct 2002 19:47:52 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/14/2002 08:49:20 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, Oct 12, 2002 at 01:46:17PM +0000, Christoph Hellwig wrote:
> Even if those existing users don't get in yet I don't want to miss the
> infrastructure in the 2.6 series.

One important thing to note: all of the RCU patches
we have constructed have shown benefit.  Since we
have not been very selective in choosing what patches
to generate, it seems a reasonable guess that other
parts of Linux would benefit as well.  There is no
shortage of read-mostly data structures in Linux!

                        Thanx, Paul


