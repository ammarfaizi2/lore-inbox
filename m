Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261897AbTCLUW1>; Wed, 12 Mar 2003 15:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261903AbTCLUW1>; Wed, 12 Mar 2003 15:22:27 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47047
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261897AbTCLUW1>; Wed, 12 Mar 2003 15:22:27 -0500
Subject: Re: bio too big device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Jens Axboe <axboe@suse.de>, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E6F7A49.50709@colorfullife.com>
References: <3E6F7A49.50709@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047505259.23725.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Mar 2003 21:40:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 18:19, Manfred Spraul wrote:
> IDE uses 127 sector requests if support for PDC4030 is compiled it, 
> otherwise 255. It seems someone started with a blacklist, but never 
> completed it.
> Does any distro enable PDC4030 support?

I'd be quite suprised. The 2.5 kernel means we can set max sectors per
channel easily so that issue is solvable too. I'd just not noticed it
until you pointed it out

