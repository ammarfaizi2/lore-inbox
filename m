Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263872AbTJEUH7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 16:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263873AbTJEUH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 16:07:59 -0400
Received: from hacksaw.org ([66.92.70.107]:53681 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id S263872AbTJEUHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 16:07:40 -0400
Message-Id: <200310052007.h95K7X6M007980@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: swap and 2.4.20 
In-reply-to: Your message of "Sun, 05 Oct 2003 20:21:27 +0200."
             <E1A6DVX-0007dB-00@calista.inka.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 Oct 2003 16:07:33 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So it's accurate to say that you can turn of swapping (by having no swap 
space), but you can't turn off paging.

One upshot of this is that the disk your root is on must be always available.

I have a real interest in this, because I have a consulting client who uses 
Linux on an embedded product. They were testing the product in a rough 
situation, and the CF card that they used to boot the system from came out of 
the slot. However, the machine kept running.

I would assume that since its programs were loaded, and it was unlikely to be 
starting new ones, it was just happily working, and would have until some 
random event would have caused it to try and do some paging. I assume that 
paging out wouldn't hurt anything, because that would just be flipping a bit 
in a table somewhere.

Does this mean that you could replace a library out from under a running but 
largely paged out app, and have it suddenly switch to the new library?
-- 
The audience is mother to the music.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


