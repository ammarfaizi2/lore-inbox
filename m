Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263409AbTDSQPr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 12:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263410AbTDSQPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 12:15:46 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:53711
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263409AbTDSQPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 12:15:46 -0400
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030419180421.0f59e75b.skraw@ithnet.com>
References: <20030419180421.0f59e75b.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050766175.3694.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Apr 2003 16:29:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-04-19 at 17:04, Stephan von Krawczynski wrote:
> after shooting down one of this bloody cute new very-big-and-poor IDE drives
> today I wonder whether it would be a good idea to give the linux-fs (namely my
> preferred reiser and ext2 :-) some fault-tolerance. I remember there have been
> some discussions along this issue some time ago and I guess remembering that it
> was decided against because it should be the drivers issue to give the fs a
> clean space to live, right?
 
Sometimes disks just go bang. They seem to do it distressingly more
often nowdays which (while handy for criminals and pirates) is annoying
for the rest of us. Putting magic in the file system to handle this is
hard to do well, and at best you get things like ext2/ext3 have now -
the ability to recover data in the event of some corruption, unless you
get into really fancy stff.

Buy IDE disks in pairs use md1, and remember to continually send the
hosed ones back to the vendor/shop (and if they keep appearing DOA to
your local trading standards/fair trading type bodies).

Perhaps someone should also start a scoreboard for people to report dead
IDE drives by vendor ;)

Alan

