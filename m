Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTEHLr5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 07:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbTEHLr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 07:47:57 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63109
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261351AbTEHLrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 07:47:55 -0400
Subject: Re: [PATCH] 2.5 ide 48-bit usage
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030508075609.GJ823@suse.de>
References: <20030507175033.GR823@suse.de>
	 <Pine.SOL.4.30.0305072119530.27561-100000@mion.elka.pw.edu.pl>
	 <20030507201949.GW823@suse.de>  <20030508075609.GJ823@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052391717.10037.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 May 2003 12:01:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-08 at 08:56, Jens Axboe wrote:
> That part is added, I still kept it at 65535 though akin to how we don't
> use that last sector in 28-bit commands either. For 48-bit commands this
> is totally irelevant, 32MiB or 32MiB-512b doesn't matter either way.

Actually I changed the LBA28 code to use the last sector a while ago. It
has (unsuprisingly) caused zero problems because other OS's also
generate such requests.

