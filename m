Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292329AbSB0LVB>; Wed, 27 Feb 2002 06:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292347AbSB0LUv>; Wed, 27 Feb 2002 06:20:51 -0500
Received: from p3EE26610.dip.t-dialin.net ([62.226.102.16]:42976 "EHLO
	artus.fbunet.de") by vger.kernel.org with ESMTP id <S292329AbSB0LUq>;
	Wed, 27 Feb 2002 06:20:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Fridtjof Busse <fridtjof.busse@gmx.de>
Message-Id: <200202271212.3529@fbunet.de>
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: [2.4.18-ac1] Unable to mount root fs
Date: Wed, 27 Feb 2002 12:21:12 +0100
In-Reply-To: <200202261722.13431@fbunet.de> <200202261907.20103@fbunet.de> <20020226181559.GQ4393@matchmail.com>
In-Reply-To: <20020226181559.GQ4393@matchmail.com>
Cc: linux-kernel@vger.kernel.org
X-OS: Linux on i686
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 26. February 2002 19:15, Mike Fedyk wrote:
> > # CONFIG_BLK_DEV_PDC202XX is not set
>
> Here you go.  Promise IDE is not compiled into the kernel.

Can someone explain me why 2.4.18 runs fine with 
# CONFIG_BLK_DEV_PDC202XX is not set
but ac1 (and 2) require
CONFIG_BLK_DEV_PDC202XX=y
It's correct that 2.4.18-ac? requires the driver (my hd's are connected 
to an promise-UDMA-controller), but why runs 2.4.18 fine without this 
driver?

-- 
Fridtjof Busse
It is better to keep your mouth shut and be thought a fool, than to
open it and remove all doubt. 
