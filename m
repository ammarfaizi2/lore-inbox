Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbVLSHTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbVLSHTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 02:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbVLSHTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 02:19:55 -0500
Received: from outmx017.isp.belgacom.be ([195.238.2.116]:918 "EHLO
	outmx017.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030280AbVLSHTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 02:19:55 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [2.6.14.3] S3 and USB
Date: Mon, 19 Dec 2005 08:19:40 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200512161535.13650.lkml@kcore.org> <20051216191648.GA4796@kroah.com>
In-Reply-To: <20051216191648.GA4796@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512190819.41051.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 December 2005 20:16, Greg KH wrote:
> On Fri, Dec 16, 2005 at 03:35:13PM +0100, Jan De Luyck wrote:
>
> > USB and the like work without problems. The only problem I have is that
> > if I leave USB 'on' and suspend, any activity to the USB ports causes my
> > laptop to resume but it never resumes correctly. I get a black screen, no
> > entries in the system logs, and I need to hold the power button to power
> > off the machine. Which is very annoying since I tend to plug in my USB
> > mouse before I open the screen.
>
> Can you try 2.6.15-rc5?  USB suspend issues are still being worked out

Thanks for the pointer, I installed 2.6.15-rc6 today and everything seems 
fine. The laptop resumes nicely no matter what happens on the USB ports.

Jan

-- 
Q:	How many IBM 370's does it take to execute a job?
A:	Four, three to hold it down, and one to rip its head off.
