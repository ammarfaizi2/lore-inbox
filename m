Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266853AbRGSF3p>; Thu, 19 Jul 2001 01:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbRGSF3e>; Thu, 19 Jul 2001 01:29:34 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:64342 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S266853AbRGSF3U>; Thu, 19 Jul 2001 01:29:20 -0400
Message-ID: <3B56706C.893FD2AE@redhat.com>
Date: Thu, 19 Jul 2001 01:30:20 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nitin Dhingra <nitin.dhingra@dcmtech.co.in>
CC: "'Florin Andrei'" <florin@sgi.com>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: noapic strikes back
In-Reply-To: <7FADCB99FC82D41199F9000629A85D1A01C6506A@dcmtechdom.dcmtech.co.in>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nitin Dhingra wrote:
> 
> I guess the problem is mostly of the scsi driver.
> Get the latest version scsi driver of that particular
> card and then try again.

No, this has been gone over a thousand times already.  It's the interrupt
routing table in these particular Intel motherboard is busted.

> -----Original Message-----
> From: Florin Andrei [mailto:florin@sgi.com]
> Sent: Thursday, July 19, 2001 1:05 AM
> To: linux-xfs@oss.sgi.com; seawolf-list@redhat.com; dledford@redhat.com;
> linux-kernel@vger.kernel.org
> Subject: noapic strikes back
> 
> I have a SGI 1200 (L440GX+ motherboard, dual PIII) and i'm trying to
> install at least one version of Red Hat 7.1 on it.
> The problem is, while booting up the installer, when it comes to loading
> up the SCSI driver (AIC7xxx) the system is frozen.
> 
> I tried the following boot disks:
> - stock Red Hat 7.1
> - Doug Ledford's updates from people.redhat.com
> - SGI XFS 1.0.1
> 
> I tried to boot the installer with and without "noapic" option.
> 
> I tried to enable and disable the APIC option in BIOS ("PCI IRQs to
> IO-APIC Mapping").
> 
> I tried all the combinations of these. No luck. :-(
> 
> Please, is there anything to do about this problem? I *have* to install
> something newer than RH7.0 on that system.
> 
> Guys, i will try whatever boot disks you will send to me. I'm willing to
> be you guinea pig. :-) Just let's kill the APIC problem for good!
> 
> --
> Florin Andrei
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
