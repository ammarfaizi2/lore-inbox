Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVFIQco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVFIQco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 12:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVFIQco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 12:32:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:9904 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261343AbVFIQcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 12:32:39 -0400
Date: Thu, 9 Jun 2005 09:32:29 -0700
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
Message-ID: <20050609163229.GC9418@kroah.com>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org> <20050607204733.1a48e5dc.khali@linux-fr.org> <20050609081035.GA23783@kroah.com> <20050609175236.6e042482.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050609175236.6e042482.khali@linux-fr.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 05:52:36PM +0200, Jean Delvare wrote:
> Hi Greg, all,
> 
> > > This one triggers a compilation warning. Proposed fix:
> > 
> > What warning?  I don't see anything here...
> 
> drivers/usb/media/pwc/pwc-uncompress.c: In function `pwc_decompress':
> drivers/usb/media/pwc/pwc-uncompress.c:140: warning: unreachable code at beginning of switch statement
> 
> This is gcc 3.3.4. Strange that you don't have it.

gcc 3.4.4 here does not show that warning.  Odd...

thanks,

greg k-h
