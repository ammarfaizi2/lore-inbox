Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280392AbRJaSbc>; Wed, 31 Oct 2001 13:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280393AbRJaSbW>; Wed, 31 Oct 2001 13:31:22 -0500
Received: from ns.caldera.de ([212.34.180.1]:45464 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S280392AbRJaSbQ>;
	Wed, 31 Oct 2001 13:31:16 -0500
Date: Wed, 31 Oct 2001 19:31:48 +0100
From: Christoph Hellwig <hch@caldera.de>
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        torvalds@transmeta.com
Subject: Re: [PATCH] init/main.c/root_dev_names - another one #ifdef
Message-ID: <20011031193148.A12919@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	torvalds@transmeta.com
In-Reply-To: <20011030182810.B800@lynx.no> <200110311728.f9VHSE207521@ns.caldera.de> <20011031112055.D16554@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011031112055.D16554@lynx.no>; from adilger@turbolabs.com on Wed, Oct 31, 2001 at 11:20:55AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 11:20:55AM -0700, Andreas Dilger wrote:
> This seems kind of ugly - an array holding each device name?  The patch
> I have rather puts a function to generate the device names when needed
> (which is probably not very often, unless GFS does something wierd).

*nod*

> I take it your patch is only the "bare bones" part which shows what is
> changed?

Well, it's a patch that tries to be not intrusive, it just crates the hooks
the two blockdevice drivers in the OpenGFS tree can use.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
