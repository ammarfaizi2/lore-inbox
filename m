Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbTEZRkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTEZRkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:40:43 -0400
Received: from devil.servak.biz ([209.124.81.2]:57554 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S261906AbTEZRkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:40:42 -0400
Subject: Re: usbserial OOPS in 2.5.69-bk4
From: Torrey Hoffman <thoffman@arnor.net>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030520001520.GA28148@kroah.com>
References: <1053380614.1141.44.camel@torrey.et.myrio.com>
	 <20030520001520.GA28148@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1053971626.1815.3.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 May 2003 10:53:47 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, things are better since I upgraded to 2.5.69-bk14

I haven't been able to cause an oops, and up until just a minute ago
things seemed to be working fine.  But on my latest sync attempt, I got
this in the dmesg log:

hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 3
usb 1-2: USB device not accepting new address=3 (error=-110)
hub 1-0:0: new USB device on port 2, assigned address 4
usb 1-2: USB device not accepting new address=4 (error=-110)
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 5
usb 1-2: USB device not accepting new address=5 (error=-110)
hub 1-0:0: new USB device on port 2, assigned address 6
usb 1-2: USB device not accepting new address=6 (error=-110)

and the sync failed.

I'll be upgrading to -bk[latest] later today anyway, and will let you
know if I see further problems with visor USB hotsync...

Torrey Hoffman
thoffman@arnor.net

On Mon, 2003-05-19 at 17:15, Greg KH wrote:
> On Mon, May 19, 2003 at 02:43:34PM -0700, Torrey Hoffman wrote:
> > I got a non-fatal oops while trying to hotsync my Handspring Visor. 
> > My system is still running as I send this email, but the hotsync didn't
> > work.
> 
> Can you try with the latest -bk tree?  I can successfully sync using it,
> but did have some problems with a few of the older revs.
> 
> thanks,
> 
> greg k-h
-- 
Torrey Hoffman <thoffman@arnor.net>

