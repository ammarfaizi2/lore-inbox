Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268268AbUJSBjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268268AbUJSBjg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 21:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268269AbUJSBjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 21:39:36 -0400
Received: from [69.4.201.55] ([69.4.201.55]:657 "EHLO bitworks.com")
	by vger.kernel.org with ESMTP id S268268AbUJSBj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 21:39:29 -0400
Message-ID: <4174704B.9050601@bitworks.com>
Date: Mon, 18 Oct 2004 20:39:23 -0500
From: Richard Smith <rsmith@bitworks.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: KendallB@scitechsoft.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video
 card BOOT?
References: <9e47339104101814166bf4cfe5@mail.gmail.com> <41740384.5783.12A07B14@localhost>
In-Reply-To: <41740384.5783.12A07B14@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kendall Bennett wrote:

> Actually there is nothing wrong with the x86 BIOS from the perspective of 
> functionality and useability (or bloat for that matter). It contains all 
> the functionality we need and armed with something like the x86 emulator 
> we can use it for what we need on any platform.

> IMHO that is the best solution to the problem because it will be using 
> code that has been heavily tested by the vendor. The one thing x86 Video 
> BIOS'es can do reliably is POST the graphics card ;-)

I'm just going to take your word on this since you have messed with far 
more video bioses than I.  I've just got a few too many scars over the 
years from trying to make the whole BIOS sub-system robust enough for 
embedded standards.

> That would be nice if you could trim it down ;-) Would certainly save a 

Check out linux-tiny (http://www.selenic.com/tiny-about/)

> lot of code bloat. But if you do that, then you would need this code in 
> the kernel since now it would be the boot loader as well ;-)

Exactly. Which is why I like your project and I think its a good thing. 
    The only reason I have to carry around the legacy BIOS baggage is 
for video.

How big is your in-kernel implementation?

-- 
Richard A. Smith


