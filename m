Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVGGVdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVGGVdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVGGVbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:31:32 -0400
Received: from isilmar.linta.de ([213.239.214.66]:61644 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261863AbVGGV3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:29:52 -0400
Date: Thu, 7 Jul 2005 23:29:50 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: st3@riseup.net
Cc: Dave Jones <davej@redhat.com>, cpufreq@lists.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: enhanced intel speedstep feature was Re: speedstep-centrino on dothan
Message-ID: <20050707212950.GA25411@isilmar.linta.de>
Mail-Followup-To: st3@riseup.net, Dave Jones <davej@redhat.com>,
	cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org
References: <20050706112202.33d63d4d@horst.morte.male> <42CC37FD.5040708@tmr.com> <20050706211159.GF27630@redhat.com> <20050706235557.0c122d33@horst.morte.male> <20050707220027.413343d4@horst.morte.male> <20050707200648.GA29142@redhat.com> <20050707222225.5b3113e0@horst.morte.male> <20050707211033.GB24774@isilmar.linta.de> <20050707232238.077c7c1c@horst.morte.male>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707232238.077c7c1c@horst.morte.male>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 11:22:38PM +0200, st3@riseup.net wrote:
> On Thu, 7 Jul 2005 23:10:33 +0200
> Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> 
> > Do you use ACPI-based idling? If so, in which state is the CPU in (cat
> > /proc/acpi/processor/*/power ? I suspect that you do not use ACPI (else 
> > you wouldn't need the table-based approach) or that the ACPI-based idling is
> > broken on your notebook; as then the Linux idle handler  only makes use of 
> > "hlt" (IIRC), that is ACPI C1, while throttling "forces" ACPI C2 (again
> >  IIRC).
> 
> For idling, I didn't mean 'real idling', but instead just 'doing nothing'
> in ACPI C1 state, that's simply a CPU usage < 1%.
> 
> Sorry for being so lame =)

That's exactly the "idling" I meant. So if it is only ACPI C1, then
throttling makes some sense. It makes more sense, though, to get ACPI C2, C3
and possibly C4 to work :)

	Dominik
