Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276305AbRI1VRO>; Fri, 28 Sep 2001 17:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276314AbRI1VRE>; Fri, 28 Sep 2001 17:17:04 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:38418 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S276305AbRI1VQy>;
	Fri, 28 Sep 2001 17:16:54 -0400
Date: Fri, 28 Sep 2001 14:12:13 -0700
From: Greg KH <greg@kroah.com>
To: Jeff DeFouw <defouwj@purdue.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 oops through usb-uhci
Message-ID: <20010928141213.B2066@kroah.com>
In-Reply-To: <Pine.LNX.4.21.0109281436100.961-100000@blorp.plorb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109281436100.961-100000@blorp.plorb.com>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 02:42:46PM -0500, Jeff DeFouw wrote:
> Guaranteed oops in 2.4.10 every time I try to access my ov511 usb
> webcam.  I copied down the Oops message with paper and pen, hopefully
> there aren't any errors.

Please use uhci.o if you can, or apply the following patch:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=100159287918217

thanks,

greg k-h
