Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270194AbTGZQv4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 12:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270427AbTGZQv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 12:51:56 -0400
Received: from mail.kroah.org ([65.200.24.183]:12973 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270194AbTGZQvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 12:51:54 -0400
Date: Sat, 26 Jul 2003 13:07:14 -0400
From: Greg KH <greg@kroah.com>
To: "J.C. Wren" <jcwren@jcwren.com>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Message-ID: <20030726170714.GC3168@kroah.com>
References: <200307262036.13989.arvidjaar@mail.ru> <200307261259.03517.jcwren@jcwren.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307261259.03517.jcwren@jcwren.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 12:59:03PM -0400, J.C. Wren wrote:
> 	Specifically using your example of USB memories, I have seen devices move 
> around just because of rebooting.  I have a Sandisk SDDR-31 (MMC) and a 
> SDDR-33 (CF) that remain plugged into the same USB ports all the time.  
> Occasionally, they come up swapped (normally the MMC reader is /dev/sda), 
> which is really infuriating, since my scripts for building MMC and CF cards 
> then exhibit much breakage.

Test out udev's ability to name devices based on bus topology (the USB
bus topology doesn't change for you.)  It should solve your problem.

thanks,

greg k-h
