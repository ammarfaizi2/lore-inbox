Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbTDHQhr (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbTDHQhr (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:37:47 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:9477 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261520AbTDHQhq (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 12:37:46 -0400
Date: Tue, 8 Apr 2003 17:49:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, page0588@sundance.sjsu.edu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - 2.5.67 - proc interface to ramdisk driver.
Message-ID: <20030408174918.A16814@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Krishnakumar. R" <krishnakumar@naturesoft.net>,
	Linus Torvalds <torvalds@transmeta.com>, page0588@sundance.sjsu.edu,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <200304082141.46820.krishnakumar@naturesoft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304082141.46820.krishnakumar@naturesoft.net>; from krishnakumar@naturesoft.net on Tue, Apr 08, 2003 at 09:41:46PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 09:41:46PM +0530, Krishnakumar. R wrote:
> Hi,
> 
> The following patch will provide a 
> proc interface to the ramdisk driver. 
> 
> Using this interface the size of the 
> ramdisk can be changed at runtime.

I think you really want a sysfs interface instead.  Maybe Rusty could
submit the patch to actually implement the sysfs acess to his new module
parameter stuff as promised and you'd get it almost for free :)


