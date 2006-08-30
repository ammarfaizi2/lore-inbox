Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWH3RyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWH3RyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWH3RyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:54:12 -0400
Received: from ns2.suse.de ([195.135.220.15]:5265 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751254AbWH3RyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:54:11 -0400
Date: Wed, 30 Aug 2006 10:52:50 -0700
From: Greg KH <greg@kroah.com>
To: Manu Abraham <abraham.manu@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
Message-ID: <20060830175250.GA6258@kroah.com>
References: <20060830062338.GA10285@kroah.com> <44F5C5E0.4050201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F5C5E0.4050201@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 09:07:44PM +0400, Manu Abraham wrote:
> 
> Being a bit excited and it is really interesting to have such a
> proposal, it would simplify the matters that held us up even more,
> probably. The name sounds fine though. All i was wondering whether there
> would be any high latencies for the same using in such a context. But
> since the transfers would occur in any way, even with a kernel mode
> driver, i think it should be pretty much fine.

As mentioned, this framework is being used in industrial settings right
now, where latencies are a huge issue.  It works just fine, so I do not
think there are any problems in this area.

thanks,

greg k-h
