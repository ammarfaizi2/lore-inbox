Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUFJMqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUFJMqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 08:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUFJMqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 08:46:35 -0400
Received: from mms1.broadcom.com ([63.70.210.58]:41486 "EHLO mms1.broadcom.com")
	by vger.kernel.org with ESMTP id S261231AbUFJMq3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 08:46:29 -0400
X-Server-Uuid: 97B92932-364A-4474-92D6-5CFE9C59AD14
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [ANNOUNCE] high-res-timers patches for 2.6.6
Date: Thu, 10 Jun 2004 05:46:07 -0700
Message-ID: <24CDBA67F085904999751B3C4F9E8C0BE3BB32@NT-RMNA-0740.brcm.ad.broadcom.com>
Thread-Topic: [ANNOUNCE] high-res-timers patches for 2.6.6
thread-index: AcRO0vIRAVuKiTn1QzGhWed+N4J68QAFTyOQ
From: "Dave Hylands" <dhylands@broadcom.com>
To: arjanv@redhat.com, "Geoff Levand" <geoffrey.levand@am.sony.com>
cc: high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, "George Anzinger" <george@mvista.com>
X-OriginalArrivalTime: 10 Jun 2004 12:46:08.0891 (UTC)
 FILETIME=[E70BDCB0:01C44EE8]
X-WSS-ID: 6CD6879B2QW7108383-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please keep in mind that some people just want the VST portion, and
don't want the high-res-timers portion (i.e. my ARM platform doesn't
have or need the hardware side of things). This may not be relevant to
your discussion of the ifdef's, but on the off chance that it was
somehow, I thought I would throw that out.

--
Dave Hylands
Vancouver, BC, Canada
http://www.DaveHylands.com/ 

> -----Original Message-----
> From: high-res-timers-discourse-admin@lists.sourceforge.net 
> [mailto:high-res-timers-discourse-admin@lists.sourceforge.net]
>  On Behalf Of Arjan van de Ven
> Sent: Thursday, June 10, 2004 3:04 AM
> To: Geoff Levand
> Cc: high-res-timers-discourse@lists.sourceforge.net; 
> linux-kernel@vger.kernel.org; George Anzinger
> Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
> 
> 
> On Thu, 2004-06-10 at 03:49, Geoff Levand wrote:
> > Available at
> > http://tree.celinuxforum.org/pubwiki/moin.cgi/CELinux_5fPatchArchive
> > 
> > For those interested, the set of three patches provide 
> POSIX high-res
> > timer support for linux-2.6.6.  The core and i386 patches 
> are updates of 
> > George Anzinger's hrtimers-2.6.5-1.0.patch available on SourceForge 
> > <http://sourceforge.net/projects/high-res-timers/>.  The 
> ppc32 port is 
> > not available on SourceForge yet.
> 
> My first impression is that it has WAAAAAAAAAAAY too many 
> ifdefs. I would strongly suggest to not make this a config 
> option and just mandatory, it's a core feature that has no 
> point in being optional. If you accept that, the code also 
> becomes a *LOT* cleaner.
> 
> 

