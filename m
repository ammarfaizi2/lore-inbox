Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265503AbTFZJWC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 05:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265507AbTFZJWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 05:22:02 -0400
Received: from mail.ithnet.com ([217.64.64.8]:63756 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S265503AbTFZJV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 05:21:59 -0400
Date: Thu, 26 Jun 2003 11:36:17 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "John Stoffel" <stoffel@lucent.com>
Cc: willy@w.ods.org, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       kpfleming@cox.net, gibbs@scsiguy.com, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030626113617.12cf3242.skraw@ithnet.com>
In-Reply-To: <16122.1630.134766.108510@gargle.gargle.HOWL>
References: <20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
	<20030611222346.0a26729e.skraw@ithnet.com>
	<16103.39056.810025.975744@gargle.gargle.HOWL>
	<20030613114531.2b7235e7.skraw@ithnet.com>
	<20030625191655.GA15970@alpha.home.local>
	<20030625214221.2cd9613f.skraw@ithnet.com>
	<16122.1630.134766.108510@gargle.gargle.HOWL>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jun 2003 16:30:22 -0400
"John Stoffel" <stoffel@lucent.com> wrote:

> >>>>> "Stephan" == Stephan von Krawczynski <skraw@ithnet.com> writes:
> 
> Stephan> I have tried that already but never managed to get
> Stephan> verification errors on tar archives written to disk.  Maybe I
> Stephan> try again some more...
> 
> I've been trying to get tar errors myself, while writing a 35gb
> filesystem to a DLT7000.  I'm now running 2.4.21-pre5-ac1 and I
> haven't seen any errors.  Yet.  I'm using the 6.2.8 version of the
> driver as well.  The filesystem is just a copy of my home directory
> and some MP3s and other random files and such.  Lots of text and jpegf
> files, along with some other stuff. 
> 
> Maybe I need to try and generate 15-18 files 2gb+ each and dump them
> to tape with tar and see how that's handled, and if we get erorrs.
> 
> Stephan, can you double check your version info as well?  And it would
> be great to get some info on your 3ware setup as well, just so we can
> work on narrowing down the issues.

Hm, I guess you mean kernel version? I am experiencing this problem since about
21-rcX versions, currently running 22-pre1.
The 3ware setup is pretty straight forward a RAID5 with 3 160 GB disks and no
spare.
I would not deny nfs to interact with this problem. Can you try to move your
backup'ed data from somewhere via nfs to your tar'ing box?

Regards,
Stephan

