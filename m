Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTEOIJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 04:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263867AbTEOIJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 04:09:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:40382 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263866AbTEOIJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 04:09:18 -0400
Date: Thu, 15 May 2003 01:07:37 -0700
From: Greg KH <greg@kroah.com>
To: mdharm-usb@one-eyed-alien.net
Cc: davej@codemonkey.org.uk, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: mysterious shifts in USB storage drivers.
Message-ID: <20030515080737.GA6669@kroah.com>
References: <200305150331.h4F3VHID000770@deviant.impure.org.uk> <20030515045637.GB5779@kroah.com> <20030515001459.A2458@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515001459.A2458@one-eyed-alien.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 12:14:59AM -0700, Matthew Dharm wrote:
> Hrm... nothing in the logs, but I remember this.  Apparently, the
> srb->result field actually requires this format.  If you look at other LLDD
> code in linux/drivers/scsi/ you'll see that the << 1 is common.
> 
> This should be in 2.5... I thought it already was.

Nope, care to send me a patch that fixes this, and the other usages of
this for 2.5?

thanks,

greg k-h
