Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTE0BBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTE0BBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:01:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12236
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262176AbTE0BBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:01:49 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jens Axboe <axboe@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305261429550.13489-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305261429550.13489-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053994617.17128.27.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 May 2003 01:16:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-26 at 22:34, Linus Torvalds wrote:
> Even if we drop our timeouts from 30 seconds (or whatever they are now)
> down to just a few seconds, that's a _loooong_ time, and we should be a
> lot more proactive about things. Audio/video stuff tends to want things
> with latencies in the tenth-of-a-second range, even when they buffer
> things up internally to hide the worst cases.

Many IDE drives will take several seconds to give up on a failing I/O
because they do all the recovery themselves. IDE CD/DVD can be
especially bad for this.

