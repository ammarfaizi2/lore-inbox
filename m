Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282663AbRK0ACv>; Mon, 26 Nov 2001 19:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282674AbRK0ACl>; Mon, 26 Nov 2001 19:02:41 -0500
Received: from pool-151-197-239-56.phil.east.verizon.net ([151.197.239.56]:51183
	"EHLO verizon.net") by vger.kernel.org with ESMTP
	id <S282663AbRK0ACc>; Mon, 26 Nov 2001 19:02:32 -0500
Date: Mon, 26 Nov 2001 19:05:08 -0500
From: Steve Lion <s.lion@verizon.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
Message-ID: <20011126190508.A23249@verizon.net>
Mail-Followup-To: Steve Lion <s.lion@verizon.net>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E168U3m-00077F-00@the-village.bc.nu> <Pine.LNX.4.33.0111261825340.15932-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111261825340.15932-100000@xanadu.home>; from nico@cam.org on Mon, Nov 26, 2001 at 06:34:26PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.4.13-ac7 with preempt patch and ext3 on this box.  I don't seem
to be encountering any unresponsiveness at all while untar'ing a kernel src.
Just some info for you guys.

-Steve
* Nicolas Pitre (nico@cam.org) wrote:
> On Mon, 26 Nov 2001, Alan Cox wrote:
> 
> > > 2.4.16 becomes very unresponsive for 30 seconds or so at a time during
> > > large unarchiving of tarballs, like tar -zxf mozilla-src.tar.gz. The
> > > file is about 36mb. I run top in one window, run free repeatedly in
> > 
> > This seems to be one of the small as yet unresolved problems with the newer
> > VM code in 2.4.16. I've not managed to prove its the VM or the differing
> > I/O scheduling rules however.
> 
> FWIW...
> 
> I experienced quite the same unresponsiveness but more in the order of 4-5
> seconds since I started to use ext3 with RH 7.2 (i.e. kernel 2.4.7 based).  
> I'm currently running 2.4.15-pre7 and the same momentary stalls are there
> just like with 2.4.7. It is much more visible when applying large patches to
> a kernel source tree as the patch output stops scrolling from time to time
> for about 5 secs.  I never saw such thing while previously using reiserfs.  
> I've yet to try reiserfs on a 2.4.16 tree to see if this is actually an ext3
> problem.
> 
> 
> Nicolas
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
