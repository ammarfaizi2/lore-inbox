Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266168AbSKFW1Z>; Wed, 6 Nov 2002 17:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266170AbSKFW1Z>; Wed, 6 Nov 2002 17:27:25 -0500
Received: from [61.11.77.75] ([61.11.77.75]:39409 "EHLO ks.tachyon.tech")
	by vger.kernel.org with ESMTP id <S266168AbSKFW1P>;
	Wed, 6 Nov 2002 17:27:15 -0500
Subject: Re: kdb source level debugging
From: K S Sreeram <ks@sreeram.cc>
To: slurn@verisign.com
Cc: kdb@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <200211062213.OAA18449@slurndal-lnx.verisign.com>
References: <200211062213.OAA18449@slurndal-lnx.verisign.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Nov 2002 03:36:13 +0530
Message-Id: <1036620491.23498.21.camel@ks>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2002-11-07 at 03:43, slurn@verisign.com wrote:
> The major problem is where to keep the source.  Since you're debugging
> the kernel, you probably don't want to keep the source on one of 
> the disks, as you may be debugging the filesystem, file cache
> or disk driver.   You can't use the buffer cache/file cache as that
> would perturb the behavior of the system under test in an undesirable
> fashion.

Why not keep the source compressed in memory. Since the primary purpose
of this feature, would be debugging/learning, the extra memory usage
will not be a problem on a 128 or 256 megs ram system. We can also come
up with schemes to store only part of the source to allow source
debugging of some parts of the kernel only.. but I wonder how much space
the extra debug info would take up?

Regards
Sreeram
Tachyon Technologies


