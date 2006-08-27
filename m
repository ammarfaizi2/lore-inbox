Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWH0Kta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWH0Kta (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 06:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWH0Kta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 06:49:30 -0400
Received: from main.gmane.org ([80.91.229.2]:51098 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750711AbWH0Kta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 06:49:30 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Peter" <sw98234@hotmail.com>
Subject: Re: wrt: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Date: Sun, 27 Aug 2006 10:49:19 +0000 (UTC)
Message-ID: <ecrtbf$ocr$1@sea.gmane.org>
References: <ecpru4$9t3$1@sea.gmane.org>
	<20060827071131.GC6932@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pool-151-204-7-242.pskn.east.verizon.net
X-Archive: encrypt
User-Agent: pan 0.109 (Beable)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006 09:11:31 +0200, Rogier Wolff wrote:

> On Sat, Aug 26, 2006 at 04:12:52PM +0000, Peter wrote:
>> Diagnostics on the drives are fine. Removing the b drive removes the
>> messages. System functions fine anyway, and no data is lost as a result
>> of the errors. The persistence of it is frustrating!
> 
> What diagnostics did you try? 
> 
First badblocks, then Manufacturer's (Maxtor) overnight burn in tests.

> (I've got experience with a guy saying: "I have 5 which test perfect
> with my diagnostics, but my embedded machine refuses them. What's
> wrong?" All of them report through SMART that they HAVE reported media
> errors, and they all have bad blocks.)

I tried to be more careful before posting here :). I even ran a second
test on the drives on a second machine.
> 
> Do you have "smartd" running? I vaguely remember that it sometimes
> triggered error messages from the normal driver.
> 
No, but I think there is a driver issue such as VMW or the reiserfs.
Reiser even mentions this error on his faq suggesting it's a bad ide
cable. Of course, I changed mine (now testing #4). Of course, switching to
NO preempt has reduced the volume of errors greatly. Even last night
there were none for the time being.

thx.

-- 
Peter
+++++
Do not reply to this email, it is a spam trap and not monitored.
I can be reached via this list, or via 
jabber: pete4abw at jabber.org
ICQ: 73676357

