Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272280AbRIKFaY>; Tue, 11 Sep 2001 01:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272282AbRIKFaN>; Tue, 11 Sep 2001 01:30:13 -0400
Received: from wire.cadcamlab.org ([156.26.20.181]:21511 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S272280AbRIKF3z>; Tue, 11 Sep 2001 01:29:55 -0400
Date: Tue, 11 Sep 2001 00:29:57 -0500
To: kaih@khms.westfalen.de, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010911002956.D582@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a0nPmXw-B@khms.westfalen.de>
User-Agent: Mutt/1.3.20i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I see two possible atime uses:
>
> 1. Cleaning up /tmp (mtime is *not* a good indicator that a file is no
> longer used)
> 2. Swapping out files to slower storage
>
> Essentially, both use the "do we still need this thing" aspect.

The Debian 'popularity-contest' package has an interesting use for
atime.  It runs weekly (if you install it, of course -- nobody *has* to
do this!) and determines when each of your installed packages was last
referenced -- then mails this anonymously to a drop box somewhere.  The
Higher Purpose here is to determine what the "most useful" Debian
packages are.  These go on the first volume of the Debian CD set, to
make a one-volume Debian CD as useful as possible.

The Windows 2000 install subsystem seems to collect similar data.
Heaven only knows whether *that* data ever makes it back to its
owners....

Peter
