Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315465AbSEBXJV>; Thu, 2 May 2002 19:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315473AbSEBXJU>; Thu, 2 May 2002 19:09:20 -0400
Received: from unthought.net ([212.97.129.24]:37526 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S315465AbSEBXJT>;
	Thu, 2 May 2002 19:09:19 -0400
Date: Fri, 3 May 2002 01:09:18 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Jeff Nguyen <jeff@aslab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE hotplug support?
Message-ID: <20020503010918.A31556@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Jeff Nguyen <jeff@aslab.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020502215833.V31556@unthought.net> <E173N9y-0004k1-00@the-village.bc.nu> <20020502231359.W31556@unthought.net> <09fa01c1f227$c8357f00$6502a8c0@jeff>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 03:22:00PM -0700, Jeff Nguyen wrote:
> You can get a sustained read speed of 80MB/s on the Adaptec 2000S
> Zero Channel RAID with 7 drives (RAID-5). But the sustained write
> speed is only around 32MB/s.
> 
> On the other hand, the 3Ware Escalade 7850 can sustain a read speed
> of 130MB/s with 8 drives (RAID-5). The write speed is 30MB/s.

So for both cards, the solution with simple IDE controllers, all on
one PCI bus, would be faster not only on RAID-5, but also RAID-1+0.

Or am I missing something ?

(I know, the IDE cabling is going to be *hell* for 15 drives if you
 want to stay within spec, and I would go SCSI or FC before that myself)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
