Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbTDEBPV (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 20:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTDEBPV (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:15:21 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:63623 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261659AbTDEBPT (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 20:15:19 -0500
Date: Fri, 4 Apr 2003 17:27:20 -0800
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] convert via686a i2c driver to sysfs
Message-ID: <20030405012720.GA5803@kroah.com>
References: <3E8D3A59.8010401@portrix.net> <20030404173250.GA1537@kroah.com> <3E8E1E91.6080503@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8E1E91.6080503@portrix.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 02:08:49AM +0200, Jan Dittmer wrote:
> Greg KH wrote:
> >On Fri, Apr 04, 2003 at 09:55:05AM +0200, Jan Dittmer wrote:
> 
> >>So 
> >>here it goes again. Tested w/ Via KT133A board and using centiVolt and 
> >>deziDegrees. Still waiting for a final decision. My vote goes to 
> >>milliVolt and milliDegree.
> >
> >
> >I thought that was the final decision, as it's what I wrote up in the
> >Documentation/i2c/sysfs-interface document that now's in the kernel :)
> >
> >Do you want to change this patch to use those units before I apply it?
> 
> At least I missed the final decision ;-) Anyway, here it goes. Btw. 

Thanks, I'll add this to my trees this weekend and send it off to Linus.
Thanks a lot for doing this.

> which other chip drivers are currently not worked on and are important? 
> So I'd convert them over the next days?

Which ones do you have the hardware for to test your changes?  :)

thanks,

greg k-h
