Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWBPWvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWBPWvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 17:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWBPWvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 17:51:49 -0500
Received: from ns2.suse.de ([195.135.220.15]:48260 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932302AbWBPWvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 17:51:49 -0500
Date: Thu, 16 Feb 2006 23:51:47 +0100
From: Karsten Keil <kkeil@suse.de>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: s.schmidt@avm.de, opensuse-factory@opensuse.org, Greg KH <greg@kroah.com>,
       torvalds@osdl.org, kkeil@suse.de, linux-kernel@vger.kernel.org,
       libusb-devel@lists.sourceforge.net
Subject: Re: [opensuse-factory] Re[2]: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB drivers of major vendor excluded
Message-ID: <20060216225147.GB8073@pingi.kke.suse.de>
Mail-Followup-To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
	s.schmidt@avm.de, opensuse-factory@opensuse.org,
	Greg KH <greg@kroah.com>, torvalds@osdl.org, kkeil@suse.de,
	linux-kernel@vger.kernel.org, libusb-devel@lists.sourceforge.net
References: <OFED05BE20.31E2BACE-ONC1257115.005DE6CA-C1257117.004F2C48@avm.de> <43F4F811.1090308@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F4F811.1090308@gmx.net>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15.7-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 11:09:21PM +0100, Carl-Daniel Hailfinger wrote:
> s.schmidt@avm.de wrote:
> > 
> > The user space does not ensure the reliability of time critical analog
> > services like Fax G3 or analog modem emulations. This quality of service
> > can only be guaranteed within the kernel space.
> > [...] To anticipate any "open vs. closed source" discussion: Only a
> > handful of companies worldwide have such know-how. With regard to our
> > competitive situation, we have to protect our hard-won intellectual
> > property and therefore cannot open the closed source part of the driver.
> 
> Thanks for clarifying the situation.
> 
> Since your intellectual property is in the DSP algorithms, are there
> any obstacles opensourcing the parts of the ISDN drivers which only
> handle normal ISDN without fax/modem emulation? This would make every
> distribution out there support your devices without any additional work
> on your side.
> You can still offer your full-featured drivers as usual.
> 

That is not the point here, some needed kernel symbols will change
to GPL_ONLY in some time, so you cannot build a binary only driver any
longer.

-- 
Karsten Keil
SuSE Labs
ISDN development
