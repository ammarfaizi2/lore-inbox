Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbTFPSem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTFPScM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:32:12 -0400
Received: from devil.servak.biz ([209.124.81.2]:12723 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S264127AbTFPS3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:29:47 -0400
Subject: Re: [OOPS] 2.5.70-bk15: RadeonFB dies at boot, and is undocumented
From: Torrey Hoffman <thoffman@arnor.net>
To: Greg KH <greg@kroah.com>
Cc: ajoshi@kernel.crashing.org, James Simmons <jsimmons@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030614000306.GA2563@kroah.com>
References: <1055546532.1256.19.camel@torrey.et.myrio.com>
	 <20030614000306.GA2563@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055788952.1187.1.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Jun 2003 11:42:33 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-13 at 17:03, Greg KH wrote:
> On Fri, Jun 13, 2003 at 04:22:13PM -0700, Torrey Hoffman wrote:
> > With the Radeon framebuffer driver compiled in, 2.5.70-bk15 oopses very
> > early during the boot process.  The oops is visible in text mode but
> > scrolls off the screen.  (I really need to set up a serial console!)
> 
> Try a later -bk version, -bk17 fixes this I think, but to be safe, use
> -bk18

Thanks, yes, this is fixed now (tested 2.5.71-bk2).

-- 
Torrey Hoffman <thoffman@arnor.net>

