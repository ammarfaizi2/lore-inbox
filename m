Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290488AbSAYBhj>; Thu, 24 Jan 2002 20:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290490AbSAYBh3>; Thu, 24 Jan 2002 20:37:29 -0500
Received: from mx5.sac.fedex.com ([199.81.194.37]:11782 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S290488AbSAYBhQ>; Thu, 24 Jan 2002 20:37:16 -0500
Date: Fri, 25 Jan 2002 09:37:34 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: ivan <ivan@es.usyd.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Physical memory versus detected memory 2.4.7-10
In-Reply-To: <Pine.LNX.4.33.0201251110180.31632-100000@dipole.es.usyd.edu.au>
Message-ID: <Pine.LNX.4.44.0201250933430.13223-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/25/2002
 09:37:11 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/25/2002
 09:37:14 AM,
	Serialize complete at 01/25/2002 09:37:14 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Jan 2002, ivan wrote:
> My server detects less memory than it available.
> 	Available memory according to the BIOS 4049MB.
>
> 	System sees only 3.7GB ???
> 	Mem:  3799580K av, 1606816K used, 2192764K free, 468K shrd, 376972K buff
> 	Swap: 8192992K av, 0K used, 8192992K free 1037532K cached

I think you need to recompile the kernel to support 64GB mem.

You current config seems to support up to 4GB only (but it is a bit
less than 4GB). I had a similar problem where I had 1GB, but saw only
9xxGB.

Jeff


