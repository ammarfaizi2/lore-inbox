Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUBRDck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUBRDck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:32:40 -0500
Received: from hb6.lcom.net ([216.51.236.182]:11649 "EHLO
	petrus.dynamic.digitasaru.net") by vger.kernel.org with ESMTP
	id S261974AbUBRDci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:32:38 -0500
Date: Tue, 17 Feb 2004 21:32:23 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Matt Domsch <Matt_Domsch@dell.com>, "Brown, Len" <len.brown@intel.com>,
       bluefoxicy@linux.net, linux-kernel@vger.kernel.org
Subject: Re: ACPI -- Workaround for broken DSDT
Message-ID: <20040218033220.GA6756@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Matt Domsch <Matt_Domsch@dell.com>,
	"Brown, Len" <len.brown@intel.com>, bluefoxicy@linux.net,
	linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8A85@hdsmsx402.hd.intel.com> <20040202083836.A20843@lists.us.dell.com> <20040217114755.GA392@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217114755.GA392@elf.ucw.cz>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Pavel Machek on Tuesday, 17 February, 2004:
>Hi!
>> > For non-vendor supplied solutions, you might also follow the DSDT link
>> > here: http://acpi.sourceforge.net/  
>> Len, this is a really good idea making this available.  May I suggest
>> you also have people provide patches between the original and their
>> modified versions, so it's easy for everyone to see what was
>> changed?
>Patches are important because some DSDTs change with memory sizes,
>too, so its safer to patch than to replace.

I'm getting ready to contact Dell (after I work through my work and
  homework backlog.  Ugh).
Firt off, how do I determine what all is broken in the DSDT/BIOS?  I know
  that the kernel refuses to use the APIC due to a 'broken BIOS'
  (Feb 16 14:38:31 petrus Dell Inspiron with broken BIOS detected. Refusing to enable the local APIC.)
  (Anyone know what I need to ask Dell to do to fix this?)  I also know
  that the fan isn't reported in ACPI, and that I've not gotten it to
  suspend to RAM successfully (I've not gotten it to suspend to disk
  successfully either, but I think that's due to software and/or my
  issues, not the BIOS/DSDT).
Also, any pointers on *how* to ask?  The above should cover the what;
  who's successfully gotten a vendor (esp. Dell) to issue a fixed BIOS
  and/or DSDT, and how did you go about it?
Thanks!

-Joseph

-- 
Joseph===============================================trelane@digitasaru.net
      Graduate Student in Physics, Freelance Free Software Developer
