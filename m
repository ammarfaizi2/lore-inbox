Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbTGOLKP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 07:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267190AbTGOLKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 07:10:15 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50373
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S267186AbTGOLKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 07:10:13 -0400
Subject: Re: RFC on io-stalls patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Chris Mason <mason@suse.com>, lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
In-Reply-To: <20030715052640.GY833@suse.de>
References: <1057932804.13313.58.camel@tiny.suse.com>
	 <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com>
	 <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random>
	 <20030714054918.GD843@suse.de>
	 <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva>
	 <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de>
	 <20030714201637.GQ16313@dualathlon.random>  <20030715052640.GY833@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058268126.3857.25.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jul 2003 12:22:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-15 at 06:26, Jens Axboe wrote:
> Sorry, but I think that is nonsense. This is the way we have always
> worked. You just have to maintain a decent queue length still (like we
> always have in 2.4) and there are no problems.

The memory pinning problem is still real - and always has been. It shows up
best not on IDE disks but large slow media like magneto opticals where you
can queue lots of I/O but you get 500K/second

