Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbTELSDI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTELSCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:02:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:13737 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262440AbTELRtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:49:08 -0400
Date: Mon, 12 May 2003 11:01:12 -0700
From: Greg KH <greg@kroah.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Andrew Morton <akpm@digeo.com>, stern@rowland.harvard.edu,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, johannes@erdfelt.com
Subject: Re: 2.5.69 Interrupt Latency
Message-ID: <20030512180112.GA28675@kroah.com>
References: <1052402187.1995.13.camel@diemos> <20030508122205.7b4b8a02.akpm@digeo.com> <1052503920.2093.5.camel@diemos> <1052512235.2997.8.camel@diemos> <20030509142828.59552d0a.akpm@digeo.com> <1052747862.1996.9.camel@diemos> <20030512162454.GA27939@kroah.com> <1052759300.1995.4.camel@diemos> <20030512173023.GB28381@kroah.com> <1052761769.1995.27.camel@diemos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052761769.1995.27.camel@diemos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 12:49:29PM -0500, Paul Fulghum wrote:
> 
> How about some sort of sanity check (as you mentioned
> earlier), so this is not shooting off all of the time
> during normal operation.

That's the proper thing to do.  Also possibly blacklisting your
motherboard's USB controller.  What does lspci -v show?

thanks,

greg k-h
