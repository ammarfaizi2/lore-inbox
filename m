Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSHSBCQ>; Sun, 18 Aug 2002 21:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316586AbSHSBCQ>; Sun, 18 Aug 2002 21:02:16 -0400
Received: from pcp809445pcs.nrockv01.md.comcast.net ([68.49.82.129]:8325 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S316580AbSHSBCQ>;
	Sun, 18 Aug 2002 21:02:16 -0400
Date: Sun, 18 Aug 2002 21:06:18 -0400
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: devfs
Message-ID: <20020818210618.A1806@zalem.puupuu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <1029709596.3331.32.camel@psuedomode> <Pine.GSO.4.21.0208181852450.3920-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0208181852450.3920-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Aug 18, 2002 at 07:03:42PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 07:03:42PM -0400, Alexander Viro wrote:
> devfs "mount" option is an idiotic kludge that makes _kernel_ mount
> it on /dev after the root fs had been mounted.  Why it had been
> introduced is a great mistery, since the normal way is to have a
> corresponding line in /etc/fstab and have userland mount whatever
> it needs.

I've been wondering, imagine that in the future we have a working
dynamic device filesystem (be it devfs, driverfs, whatever) nice
enough that we don't want a disk-based /dev anymore.  How are we
supposed to mount it so that the kernel's open("/dev/console")
succeeds?

  OG.

