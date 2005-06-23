Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVFWN1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVFWN1I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 09:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbVFWNXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 09:23:15 -0400
Received: from styx.suse.cz ([82.119.242.94]:15566 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262329AbVFWNSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 09:18:44 -0400
Date: Thu, 23 Jun 2005 15:18:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: "'Eric Piel'" <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       "'Pavel Machek'" <pavel@ucw.cz>, "'Lee Revell'" <rlrevell@joe-job.com>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: IBM HDAPS Someone interested?
Message-ID: <20050623131842.GA13276@ucw.cz>
References: <42BA89B4.50900@tremplin-utc.net> <004001c577f2$865ab650$600cc60a@amer.sykes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004001c577f2$865ab650$600cc60a@amer.sykes.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 06:53:15AM -0600, Alejandro Bonilla wrote:
>   
> > > But that doesn't mean it's not connected to the embedded 
> > controller. It
> > > just means the embedded controller doesn't generate any 
> > inertial events
> > > by itself - it may have to be polled with some specific command.
> > > 
> > 
> > Well, in the changelog of the embedded controller firmware 
> > (ftp://ftp.software.ibm.com/pc/pccbbs/mobiles/1uhj07us.txt) there is:
> > - (New) Support for IBM Hard Disk Active Protection System.
> > 
> > I would conclude that the embedded controller is involved 
> > with the HDAPS!
> > 
> > Just my two cents.
> > 
> > Eric
> > 
> OK, awesome. This gives us pretty much a where to go from now.
> 
> Should the IBM-ACPI project have anything to do with this? I mean, we
> should, or could be getting more -vvv information from ecdump or the
> fact that because this is attached to the embedded controller makes
> things harder?
 
We'll likely have to take a look at the extra IBM ACPI BIOS methods the
BIOS exports and see if any of them is interfacing to the EC.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
