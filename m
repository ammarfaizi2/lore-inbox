Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270609AbTGZWgS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 18:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270592AbTGZWgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 18:36:18 -0400
Received: from [66.62.77.7] ([66.62.77.7]:63455 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S270625AbTGZWgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 18:36:13 -0400
Subject: Re: Does sysfs really provides persistent hardware path to devices?
From: Dax Kelson <dax@gurulabs.com>
To: jcwren@jcwren.com
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <200307261259.03517.jcwren@jcwren.com>
References: <200307262036.13989.arvidjaar@mail.ru>
	 <200307261259.03517.jcwren@jcwren.com>
Content-Type: text/plain
Message-Id: <1059259884.2924.37.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 26 Jul 2003 16:51:24 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-26 at 10:59, J.C. Wren wrote:
> 	Specifically using your example of USB memories, I have seen devices move 
> around just because of rebooting.  I have a Sandisk SDDR-31 (MMC) and a 
> SDDR-33 (CF) that remain plugged into the same USB ports all the time.  
> Occasionally, they come up swapped (normally the MMC reader is /dev/sda), 
> which is really infuriating, since my scripts for building MMC and CF cards 
> then exhibit much breakage.

man devlabel in Red Hat Linux 9 and above would solve this 100% for you.

Also, the devlabel home page:

http://www.lerhaupt.com/linux.html

and a whitepaper on it:

http://www.dell.com/us/en/esg/topics/power_ps1q03-lerhaupt.htm

