Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbTDERpr (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 12:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTDERpr (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 12:45:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39053
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262599AbTDERpq (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 12:45:46 -0500
Subject: Re: New Software Suspend Patch for testing.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@digeo.com>
In-Reply-To: <20030404230320.GB154@elf.ucw.cz>
References: <1049454721.2418.33.camel@laptop-linux.cunninghams>
	 <20030404133037.GA1333@elf.ucw.cz>
	 <1049486400.3512.12.camel@laptop-linux.cunninghams>
	 <20030404230320.GB154@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049561916.25758.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Apr 2003 17:58:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-04-05 at 00:03, Pavel Machek wrote:
> > Yes. Under 2.4, some people found that if the writeback cache isn't
> > flushed before we powerdown, the image isn't completely saved. This was
> > the fix (the first test is the original one, the second is based upon
> > hdparm's tests for writeback cache).
> 
> But this looks like you are fixing generic bug, which could make
> kernel do something very wrong even without swsusp, right? If so,
> submit it to Alan, ASAP.

I'll grab the older ATA spec and take a look. The other changes are
broken, but this one looks quite beliavable

