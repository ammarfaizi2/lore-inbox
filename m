Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292874AbSB1Bxi>; Wed, 27 Feb 2002 20:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293123AbSB1Bwy>; Wed, 27 Feb 2002 20:52:54 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:35060
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293126AbSB1BwZ>; Wed, 27 Feb 2002 20:52:25 -0500
Date: Wed, 27 Feb 2002 17:53:04 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Fridtjof Busse <fridtjof.busse@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.18-ac1] Unable to mount root fs
Message-ID: <20020228015304.GU4393@matchmail.com>
Mail-Followup-To: Fridtjof Busse <fridtjof.busse@gmx.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200202261722.13431@fbunet.de> <200202261907.20103@fbunet.de> <20020226181559.GQ4393@matchmail.com> <200202271212.3529@fbunet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202271212.3529@fbunet.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 12:21:12PM +0100, Fridtjof Busse wrote:
> On Tuesday, 26. February 2002 19:15, Mike Fedyk wrote:
> > > # CONFIG_BLK_DEV_PDC202XX is not set
> >
> > Here you go.  Promise IDE is not compiled into the kernel.
> 
> Can someone explain me why 2.4.18 runs fine with 
> # CONFIG_BLK_DEV_PDC202XX is not set
> but ac1 (and 2) require
> CONFIG_BLK_DEV_PDC202XX=y
> It's correct that 2.4.18-ac? requires the driver (my hd's are connected 
> to an promise-UDMA-controller), but why runs 2.4.18 fine without this 
> driver?

-ac does have Andre's new IDE drivers that are waiting for inclusion...
