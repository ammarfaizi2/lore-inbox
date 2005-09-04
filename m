Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbVIDIFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVIDIFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 04:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVIDIFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 04:05:24 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:17990 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751286AbVIDIFX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 04:05:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YPEYBvVpNq2IaIERBEwJNcHJG+aj2mBH9f+XkiT83NzgzX9vx3HVSmCOxQI5/WVw/l3VYvwaizOjGQRgWoueNYYuSaiwdJti5GCubVFG2+oZ50oy2thRyl+IqpZFHJaezLNLn8kVNF3AqhweMJtNx8GbLAsSREuExZSwl4xGhiY=
Message-ID: <195c7a9005090401055146141@mail.gmail.com>
Date: Sun, 4 Sep 2005 16:05:22 +0800
From: roucaries bastien <roucaries.bastien@gmail.com>
To: Paul Misner <paul@misner.org>
Subject: Re: Brand-new notebook useless with Linux...
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200509040153.57751.paul@misner.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509031859_MC3-1-A720-F705@compuserve.com>
	 <200509040153.57751.paul@misner.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, Paul Misner <paul@misner.org> wrote: 
> On Saturday 03 September 2005 5:58 pm, Chuck Ebbert wrote:
> > I just bought a new notebook.  Here is the output from lspci using the 
> > latest pci.ids file from sourceforge:
> >
> ...
> > controller: Broadcom Corporation BCM4318 [AirForce One 54g] 802.11g
> > Wireless LAN Controller (rev 02) 05:09.0 CardBus bridge: Texas Instruments
> > 05:09.4 Class 0805: Texas Instruments PCI6411, PCI6421, PCI6611, PCI6621,
> > PCI7411, PCI7421, PCI7611, PCI7621 Secure Digital (SD) Controller
> >
> > None of these work and I can find no support anywhere for them: 
> >
> > SMBus
> > Audio ("unknown codec")
> > Modem ("no codec available")
> > Wireless
> > FlashMedia
> > SD/MMC
> >
> > Additionally, the system clock runs at 2x normal speed with PowerNow 
> > enabled.
> >
> > Am I stuck with running XP on this thing?
> >
> > __
> > Chuck
> > -
> 
> >You already had an answer on the audio.  Your answer on the wireless is
> >ndiswrapper.  You should really be looking at the Linux r3000 list, which 
> >handles much more than that now.  The information for that list is:
> >
> >LinuxR3000 mailing list
> >LinuxR3000@lists.pcxperience.com
> > http://lists.pcxperience.com/cgi-bin/mailman/listinfo/linuxr3000
> >Wiki at http://prinsig.se/weekee/
 
 
Or help to rewrite from scracth broadcom drivers see
http://bcm-specs.sipsolutions.net/ for the specs. Unfortunatly, I have
no time to do this but I expect somebody have...
 
> >If those folks don't know how to make you notebook run, you are in serious
> >trouble.  I have a Compaq R3120US, which I learned how to set up from the 
> >people over there.  Notebooks are very different from most other computers,
> >and you can expect to take some extra time and effort to get one set up.
> 
> >An important note about your wireless is that even with ndiswrapper, not all 
> >Windows drivers are created equal, and you may need to try several for the
> >same chip from different sources to find one that works.
> 
> >Good luck with your SD/MMC reader, that tends to be something that doesn't 
> >work under Linux because the manufacturers haven't released the information
> >needed to create proper drivers for them.
> 
> >Mandriva tends to work great on notebooks, once you install the proper
> >wireless driver, I have had good luck with Mepis as well, and I know many 
> >people running Fedora as well.  Your other big challenge, maybe the biggest
> >one, is going to be the display, at least if you have an uncommon display
> >like the 1280 X 800 on my notebook.
> 
> >Paul 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at   http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
