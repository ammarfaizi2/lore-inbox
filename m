Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbTDKWof (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbTDKWoe (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:44:34 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:9349 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262024AbTDKWoZ (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 18:44:25 -0400
Date: Fri, 11 Apr 2003 15:58:18 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411225818.GE3786@kroah.com>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <3E9725C5.3090503@mvista.com> <20030411204329.GT1821@kroah.com> <3E9741FD.4080007@mvista.com> <20030411223856.GI21726@marowsky-bree.de> <3E974500.7050700@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E974500.7050700@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 03:43:12PM -0700, Steven Dake wrote:
> 
> Lars Marowsky-Bree wrote:
> 
> >On 2003-04-11T15:30:21,
> >  Steven Dake <sdake@mvista.com> said:
> >
> > 
> >
> >>There is no "spec" that states this is a requirement, however, telecom 
> >>customers require the elapsed time from the time they request the disk 
> >>to be used, to the disk being usable by the operating system to be 20 
> >>msec.
> >>   
> >>
> >
> >Heh. Yes, I've read that spec, and some of it involves some good crack 
> >smoking
> >;-) The current Linux scheduler will make that rather hard for you, you'll
> >need hard realtime for such guarantees.
> >
> Its quite easy to do if you are not dependent upon spawning an entire 
> process to execute the insertion and creation even of the device node.

Then have the telcos live with the static /dev that they have today :)

There's always a price to pay for new features...

greg k-h

Happily using his "pleasure boating" version of Linux...
