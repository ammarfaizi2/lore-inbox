Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268054AbUJSGsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268054AbUJSGsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 02:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268053AbUJSGsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 02:48:43 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:6289 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268058AbUJSGse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 02:48:34 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: forcing PS/2 USB emulation off
Date: Tue, 19 Oct 2004 01:48:30 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, Alexandre Oliva <aoliva@redhat.com>,
       linux-kernel@vger.kernel.org
References: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br> <20041018164539.GC18169@kroah.com> <20041019063057.GA3057@ucw.cz>
In-Reply-To: <20041019063057.GA3057@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410190148.30386.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 October 2004 01:30 am, Vojtech Pavlik wrote:
> On Mon, Oct 18, 2004 at 09:45:39AM -0700, Greg KH wrote:
> 
> > I'm a little leary of changing the way the kernel grabs the USB hardware
> > from the way we have been doing it for the past 6 years.  So by
> > providing the option for people who have broken machines like these, we
> > will let them work properly, and it should not affect any of the zillion
> > other people out there with working hardware.
> > 
> > Or, if we can determine a specific model of hardware that really needs
> > this option enabled, we can do that automatically.  If you look at the
> > patch, we do that for some specific IBM machines for this very reason.
> > 
> > Is there any consistancy with the type of hardware that you see being
> > reported for this issue?
>  
> Like 30% of all notebooks? ;) They do boot without the USB handoff, the
> PS/2 mouse works, but only as a PS/2 mouse, no extended capabilities
> detection is possible due to the BIOS interference.
> 

I will send a list of examples tomorrow but so far it includes IBM
Thinkpads, Dells, Sonys, Compaqs, Fujitsus, Toshibas, Supermicro-based
boards and nonames. 

We risk growing that DMI list pretty big ;)

-- 
Dmitry
