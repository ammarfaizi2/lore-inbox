Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVEBUzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVEBUzU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 16:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVEBUw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 16:52:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:47833 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261745AbVEBUwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 16:52:20 -0400
Date: Mon, 2 May 2005 13:41:36 -0700
From: Greg KH <greg@kroah.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>
Subject: Re: [PATCH] ds1337 3/4
Message-ID: <20050502204136.GE32713@kroah.com>
References: <20050407231848.GD27226@orphique> <u5mZNEX1.1112954918.3200720.khali@localhost> <20050408130639.GC7054@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408130639.GC7054@orphique>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 03:06:39PM +0200, Ladislav Michl wrote:
> On Fri, Apr 08, 2005 at 12:08:38PM +0200, Jean Delvare wrote:
> > Looks OK to me.
> 
> Ok, I have few more fixes for this driver and will send them later
> when I find time to split them out into smaller chunks. Again, here is
> patch with signed off line.
> 
> 
> dev_{dbg,err} functions should print client's device name. data->id can
> be dropped from message, because device is determined by bus it hangs on
> (it has fixed address).
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Applied, thanks.

greg k-h

