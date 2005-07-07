Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVGGUya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVGGUya (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 16:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVGGUya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 16:54:30 -0400
Received: from kludge.physics.uiowa.edu ([128.255.33.129]:3332 "EHLO
	kludge.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S261314AbVGGUy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 16:54:29 -0400
Date: Thu, 7 Jul 2005 15:51:17 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: st3@riseup.net
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       cpufreq@lists.linux.org.uk
Subject: Re: enhanced intel speedstep feature was Re: speedstep-centrino on dothan
Message-ID: <20050707205117.GB10635@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: st3@riseup.net, Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
References: <20050706112202.33d63d4d@horst.morte.male> <42CC37FD.5040708@tmr.com> <20050706211159.GF27630@redhat.com> <20050706235557.0c122d33@horst.morte.male> <20050707220027.413343d4@horst.morte.male> <20050707200648.GA29142@redhat.com> <20050707222225.5b3113e0@horst.morte.male>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707222225.5b3113e0@horst.morte.male>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Just a latest question: can be p4-clockmod used together with
>speedstep-centrino? If not, would it make any sense to patch
>speedstep-centrino to use this feature too?

I'm a little confused.  How is this different from the ACPI CPU throttling
  states (/proc/acpi/processor/CPUn/limit to set, throttling to see all
  T-states available)?
On my 1.5-year-old Pentium-M, frequency scaling and T-states are different
  beasties, and act entirely differently.  I'm currently in the process of
  rewriting my governor's brain to deal with the two more intelligently.

-Joseph

-- 
Joseph===============================================trelane@digitasaru.net
      Graduate Student in Physics, Freelance Free Software Developer
