Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130086AbRBVJrD>; Thu, 22 Feb 2001 04:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbRBVJqx>; Thu, 22 Feb 2001 04:46:53 -0500
Received: from ns.caldera.de ([212.34.180.1]:59910 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130086AbRBVJqq>;
	Thu, 22 Feb 2001 04:46:46 -0500
Date: Thu, 22 Feb 2001 10:46:04 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: lvm-devel@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] *** ANNOUNCEMENT *** LVM 0.9.1 beta5 available at www.sistina.com
Message-ID: <20010222104603.A1992@caldera.de>
Mail-Followup-To: Peter Samuelson <peter@cadcamlab.org>,
	lvm-devel@sistina.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010221180035.N25927@athlon.random> <200102211718.SAA25997@ns.caldera.de> <20010221221225.B21010@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010221221225.B21010@cadcamlab.org>; from peter@cadcamlab.org on Wed, Feb 21, 2001 at 10:12:25PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2001 at 10:12:25PM -0600, Peter Samuelson wrote:
> 
> [Christoph Hellwig]
> > It would be really good to have something devfs-like just for LVM in
> > setups that don't use LVM, so we could avoid mounting root read/write
>                         ^^^devfs?

Yes...

> > for device-creation.
> 
> For most people, read/write access to /dev is rarely needed -- how
> often do you create new VGs or LVs?  How often do you run MAKEDEV or
> vgscan?

On every bootup, _before_ doing mount -a

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
