Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbTJZPwT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 10:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbTJZPwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 10:52:19 -0500
Received: from karnickel.franken.de ([193.141.110.11]:29188 "EHLO
	karnickel.franken.de") by vger.kernel.org with ESMTP
	id S263228AbTJZPwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 10:52:18 -0500
Date: Sun, 26 Oct 2003 15:42:48 +0100
To: Thilo Schulz <arny@ats.s.bawue.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Files burnt to DVDs corrupt when DMA enabled, tested with Kernel 2.4 and 2.6 series.
Message-ID: <20031026144247.GA14050@debian.franken.de>
References: <200310261241.20531.arny@ats.s.bawue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310261241.20531.arny@ats.s.bawue.de>
User-Agent: Mutt/1.5.4i
From: erik@debian.franken.de (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26, 2003 at 12:41:12PM +0100, Thilo Schulz wrote:
> I have recently used the dvd+rwtools released by Andy Polyakov to burn DVDs on
> my Pioneer DVR-A06 burner.
> After burning, I ran a diff on the resulting files and found the burnt file to 
> be different from the original. A closer examination revealed, that a few
> chunks of each having a length of exactly 28 bytes had been written
> incorrectly to the DVD.
> The count of incorrectly written chunks depends strongly on additional
> activity to the burning process itself. The more I work on the gui (browse
> the web etc.), the more errors are written.

I think I can confirm this problem but give not so much informations. I
had a 1200 Mhz Athlon running on a board with a onboard-controller and a
promise udma 100 controller. I connected my dvd-write to one of these
controllers, I don't know which anymore and I had corrupted data too,
the system had nearly no load and I would guess that I had perpahs 5
places on a dvd which where corrupted. I used dma. The writer and the
cable worked fine in a system with a dual-p3 with intel bx chipset. I
think I was running a 2.4 kernel, newer than 2.4.20 I think. I currently
got this system offline because I am moving. If you need more
informations I will perhaps be able to gain them in a week or so.
