Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUDSQan (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUDSQan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:30:43 -0400
Received: from ns1.server262.com ([64.14.68.15]:6812 "HELO server262.com")
	by vger.kernel.org with SMTP id S261426AbUDSQaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:30:39 -0400
Date: Mon, 19 Apr 2004 12:30:36 -0400
From: Adam Goode <adam@evdebs.org>
To: "Cef (LKML)" <cef-lkml@optusnet.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ifplugd/e1000 oops
Message-ID: <20040419163036.GA1757@evdebs.org>
References: <20040419050001.GE4288@evdebs.org> <200404191532.01938.cef-lkml@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404191532.01938.cef-lkml@optusnet.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's ifplugd version 0.23-1 (Debian). Kernel version 2.6.6-rc1.

I have a serial console, so I can help however I can. My machine is a
ThinkPad X40, running without ACPI.


Adam



On Mon, Apr 19, 2004 at 03:32:00PM +1000, Cef (LKML) wrote:
> On Mon, 19 Apr 2004 03:00 pm, Adam Goode wrote:
> 
> > I'm using ifplugd to monitor the link beat and automatically bring up
> > or down the network interfaces on my laptop.
> >
> > When I unplugged my cable today, I got an oops. When I plugged it back
> > in, nothing happened. (Normally it should beep and bring the interface
> > back up.) When I removed and inserted the e1000 module, I got a freeze.
> 
> I've got a report of a similar oops, also using ifplugd. User in question (on 
> IRC) is complaining that this has been happening for all of 2.6, in late 2.5 
> (hasn't pinpointed any specific version) and in 2.4 since about 2.4.23.
> 
> Unfortunately in his case, it dies processing interrupts, so he gets nothing 
> on disk, and is reluctant to set up a serial console on his box. I've tried 
> emulating it here, but as yet have had no luck in getting it to oops.
> 
> Note: He's using an Intel EEPro/100B in his box, though he has a spare 
> (unused) Realtek 8029 in there as well.
> 
> BTW: Kernel & ifplugd versions might be useful.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
