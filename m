Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131413AbQKIVqQ>; Thu, 9 Nov 2000 16:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131414AbQKIVqG>; Thu, 9 Nov 2000 16:46:06 -0500
Received: from relay1.scripps.edu ([137.131.200.29]:15809 "EHLO
	relay1.scripps.edu") by vger.kernel.org with ESMTP
	id <S131413AbQKIVp4>; Thu, 9 Nov 2000 16:45:56 -0500
Date: Thu, 9 Nov 2000 13:45:48 -0800 (PST)
From: Brian Marsden <marsden@scripps.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.2.18-pre20 AMI Megaraid & Dell Percraid drivers
In-Reply-To: <Pine.LNX.4.21.0011091616510.18481-300000@winds.org>
Message-ID: <Pine.LNX.4.21.0011091344080.9750-100000@eurus.scripps.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2000, Byron Stanoszek wrote:

> On Thu, 9 Nov 2000, Brian Marsden wrote:
> 
> > 2.2.18pre20 (still) hangs on boot when it gets to the part where it
> > detects the MEGARAID card. 
> > 
> > This is a shame, since 2.2.18 with NFS3 would be very nice on a big
> > filestore such as the one this is running on.
> 
> I've been running the megaraid and aacraid patches on our Dell 2.2.18 pre16-20
> kernels for almost 2-3 weeks now. We are now classifying these machines in the
> 'production state' as they have been stable for me throughout the duration of
> our testing and benchmarking process.
> 
> The patches below are mutually exclusive and patch cleanly with 2.2.18-pre20.
> I have not written them, but have cleaned them up a little and have performed
> at least 2 weeks of extensive testing on them. Alan, if you will please,
> include these patches in the next kernel (2.2.19 if anything) which will fix
> the megaraid hanging problem and support Dell's Percraid controller (for 2/si,
> 3/si, and 3/di models).

I can confirm that the megaraid patch applies fine, boots fine and (so
far) works fine.

Thanks, Byron!

Brian

-- 
---------------------------------------------------------------------
 Brian Marsden        			  Email: marsden@scripps.edu
 TSRI, San Diego, USA.  Phone: +1 858 784 8698  Fax: +1 858 784 8299
---------------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
