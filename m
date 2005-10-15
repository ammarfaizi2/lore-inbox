Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbVJOBnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbVJOBnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 21:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVJOBnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 21:43:22 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:9109 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751011AbVJOBnV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 21:43:21 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Greg KH <greg@kroah.com>, akpm@osdl.org
Subject: Re: [PATCH] Re: bug in handling of highspeed usb HID devices
Date: Fri, 14 Oct 2005 21:43:21 -0400
User-Agent: KMail/1.8.2
Cc: Christian Krause <chkr@plauener.de>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Chris Wright <chrisw@osdl.org>
References: <m34q7mwlvv.fsf@gondor.middle-earth.priv> <m3oe5riwib.fsf@gondor.middle-earth.priv> <20051014234225.GA11301@kroah.com>
In-Reply-To: <20051014234225.GA11301@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510142143.21944.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 October 2005 19:42, Greg KH wrote:
> Did you try this patch out?  It is wrong.  Please look at the
> compiler warning that this change generates and redo the patch.

[CC'ed Andrew - likely he has the wrong patch queued up.]

And to save Christian some time, here is a hint - interval is used 
uninitialized!

Parag
