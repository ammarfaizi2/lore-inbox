Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281170AbRKYWcA>; Sun, 25 Nov 2001 17:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281174AbRKYWbu>; Sun, 25 Nov 2001 17:31:50 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:5295 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281170AbRKYWbm>; Sun, 25 Nov 2001 17:31:42 -0500
Date: Sun, 25 Nov 2001 15:31:42 -0700
Message-Id: <200111252231.fAPMVgb05670@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Paul Bristow <paul@paulbristow.net>
Cc: Jack Howarth <howarth@nitro.med.uc.edu>, linux-kernel@vger.kernel.org
Subject: Re: ide-floppy.c vs devfs
In-Reply-To: <3C016B85.7040207@paulbristow.net>
In-Reply-To: <200111110439.XAA53352@nitro.msbb.uc.edu>
	<3C016B85.7040207@paulbristow.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Bristow writes:
> Hi Jack,
> 
> Try the devfs test version that I just uploaded to
> 
> http://paulbristow.net/linux/idefloppy.html
> 
> This is early days, and I'm not sure what the best approach is...
> 
> Feedback is greatly appreaciated.

I haven't had time to look at this closely, but I question why you're
trying to prevent grok_partitions() from doing it's thing. There's
supposed to be a flag set for removable media which ensures media
revalidation on scanning the parent directory or looking up an entry.
I'd rather see that mechanism fixed.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
