Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUG2WGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUG2WGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUG2WGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:06:31 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:40310 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S265256AbUG2WG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:06:28 -0400
From: "Shawn Starr" <shawn.starr@rogers.com>
To: "'Vernon Mauery'" <vernux@us.ibm.com>,
       "'David Weinehall'" <tao@debian.org>
Cc: "'Brown, Len'" <len.brown@intel.com>,
       "'lkml'" <linux-kernel@vger.kernel.org>, <linux-acpi@intel.com>
Subject: RE: [ACPI][2.6.8-rc2-bk #] - ACPI shutdown problems on IBMThinkpads (T42)
Date: Thu, 29 Jul 2004 18:06:46 -0400
Message-ID: <000701c475b8$5737e650$0200080a@panic>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <1091120589.14718.4.camel@bluerat>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The buttons sort of work. The video however, does not turn on with X loaded
or without. I get a blank screen. You can tell the machine is powered back
on because you can log into it still (and run find command to see hard disk
activity).

Something else I noticed, when ACPI fails to shut the machine down fully,
and I hold the power button to shut it off completely, I hear a buzzing
sound from the back, if I remove the battery and plug it back in the laptop
becomes completely silent. I'm not sure what this is though (?).

That issue I don't think is connected to ACPI. 

> -----Original Message-----
> From: Vernon Mauery [mailto:vernux@us.ibm.com] 
> Sent: Thursday, July 29, 2004 13:03
> To: David Weinehall
> Cc: Shawn Starr; 'Brown, Len'; lkml
> Subject: Re: [ACPI][2.6.8-rc2-bk #] - ACPI shutdown problems 
> on IBMThinkpads (T42)
> 
> 
> The latest (acpi-20040715) ACPI patch against 2.6.7/2.6.8-rc2 
> works on my T40 to bring back ACPI  interrupts after 
> suspend/resume.  I don't know if these will apply to the bk 
> tree or not.  It also makes it so other buttons besides the 
> power button can wake up the machine (like the Fn button).
> 
> --Vernon
> 
> On Wed, 2004-07-28 at 23:43, David Weinehall wrote:
> > On Wed, Jul 28, 2004 at 11:05:00PM -0400, Shawn Starr wrote:
> > > 
> > > I'll keep looking for patches as you get time.
> > > 
> > > I appreciate your help.
> > 
> > Disable APIC support and shutdown will work.
> > 
> > Meanwhile, has anyone solved the problem with the 
> Thinkpad-keys after 
> > a suspend/resume?  Volume keys still work, as does the brightness 
> > keys, but Fn+F4 for suspend doesn't (manual suspend still 
> works), and 
> > tpb doesn't see any of the Thinkpad specific keypresses any longer 
> > ("Access IBM", Fn+Fx, etc), not even if I restart tpb, and 
> > /proc/interrupts:acpi indicates that interrups are not working for 
> > ACPI any longer.  All other interrupts seem to function 
> properly, and 
> > I have both patches from [1] applied.
> > 
> > [1] http://bugme.osdl.org/show_bug.cgi?id=2643
> > 
> > 
> > Regards: David Weinehall
> 

