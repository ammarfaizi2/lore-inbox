Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVIPXwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVIPXwV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 19:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVIPXwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 19:52:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:24252 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750744AbVIPXwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 19:52:21 -0400
Date: Fri, 16 Sep 2005 16:20:54 -0700
From: Greg KH <greg@kroah.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org, rbh00@utsglobal.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/7] s390: 3270 fullscreen view.
Message-ID: <20050916232054.GA15387@kroah.com>
References: <20050914155345.GA11478@skybase.boeblingen.de.ibm.com> <20050914161022.GA4230@infradead.org> <1126719107.4908.29.camel@localhost.localdomain> <20050915172432.GA9980@kroah.com> <1126858028.4923.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126858028.4923.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 10:07:08AM +0200, Martin Schwidefsky wrote:
> 
> To cut the long story short, there is more to a 3270 device then the tty
> view. In fact you can compile the 3270 driver without the tty view and
> only with the fullscreen view. We still should have a class for the
> devices, do we not ?

For that, yes, I don't have a problem.  Just wanted to make sure you
weren't creating new tty devices in the /sys/class tree, as those should
remain under the /sys/class/tty/ tree.

thanks,

greg k-h
