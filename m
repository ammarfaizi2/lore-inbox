Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbTDKXeP (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTDKXdr (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:33:47 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:6571 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261857AbTDKXcC (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 19:32:02 -0400
Date: Fri, 11 Apr 2003 16:45:43 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411234543.GG4539@kroah.com>
References: <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <3E9725C5.3090503@mvista.com> <20030411204329.GT1821@kroah.com> <3E9741FD.4080007@mvista.com> <20030411223856.GI21726@marowsky-bree.de> <3E974500.7050700@mvista.com> <20030411225818.GE3786@kroah.com> <3E9750A6.1050803@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9750A6.1050803@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 04:32:54PM -0700, Steven Dake wrote:
> >Then have the telcos live with the static /dev that they have today :)
> >
> Unfortunately they are willing to live with devfs, but not a static 
> /dev....  There are problems with devfs which I'm sure your well aware 
> of which a dynamic /dev would solve...  But performance is an important 
> goal.

Adam's rewrite of devfs has removed many of the older problems, it looks
quite good now, and I'm not advocating for it's removal anymore.

Different requirements result in different solutions, so if the telcos
find their requirements met in devfs, by all means, they should use it.

thanks,

greg k-h
