Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131345AbRCNNDS>; Wed, 14 Mar 2001 08:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131346AbRCNNDI>; Wed, 14 Mar 2001 08:03:08 -0500
Received: from www.inreko.ee ([195.222.18.2]:42227 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S131345AbRCNNC6>;
	Wed, 14 Mar 2001 08:02:58 -0500
Date: Wed, 14 Mar 2001 15:15:15 +0200
From: Marko Kreen <marko@l-t.ee>
To: Dalton Calford <dcalford@distributel.ca>
Cc: Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: DPT Driver Status
Message-ID: <20010314151515.A3954@l-t.ee>
In-Reply-To: <3AAF1072.A38B2508@distributel.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AAF1072.A38B2508@distributel.ca>; from dcalford@distributel.ca on Wed, Mar 14, 2001 at 01:32:18AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2001 at 01:32:18AM -0500, Dalton Calford wrote:
> I have searched the archives, hunted through the adaptec site, tried
> multiple patches, compilers, revisions.....

Me too...

> 
> I have a DPT/Adaptec DPT RAID V century card.  This has been a topic of
> much discussion in the past on this list.  
> 
> What I have found is that almost every file I find has a patch that is 6
> months old at best.

When I last contacted them, couple of months ago, through
I-dunno-how-many-middle[wo]men they assured that
"driver is in developement" and "soon we make a release"...

> I even contacted Deanna Bonds at Adaptec, but she has been unresponsive.
> 
> Does anyone have a working patch for the 2.2.18 kernel? 
> What is the most stable version of the kernel for the use of the patch?

I have ported the 1.14 version of the driver to 2.2.18.
Basically converted their idea of patching with cp to
normal diff and dropped all reverse changes.

  http://www.l-t.ee/marko/linux/dpt114-2.2.18p22.diff.gz

It was for pre22 but applies cleanly to final 2.2.18.
The other soft was most current in valinux site:

  http://ftp.valinux.com/pub/mirrors/dpt/

> Has the native i2o driver been updated to handle what the dpt card is
> doing?

No, the DPT driver has not been updated to native Linux i2o.

Note: the driver compiles only with gcc 2.7.2.3, (dunno about
egcs).  2.95.2 makes it acting weird.  I do not know if
thats gcc or driver problem.

-- 
marko

