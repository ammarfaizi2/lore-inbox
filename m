Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWCFRSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWCFRSM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWCFRSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:18:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5027 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750922AbWCFRSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:18:12 -0500
Date: Mon, 6 Mar 2006 12:17:47 -0500
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Ellerman <michael@ellerman.id.au>,
       "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [PATCH] leave APIC code inactive by default on i386
Message-ID: <20060306171747.GN21445@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	Michael Ellerman <michael@ellerman.id.au>,
	"Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
	Chris McDermott <lcm@us.ibm.com>
References: <43D03AF0.3040703@us.ibm.com> <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com> <20060301043353.GJ28434@redhat.com> <20060306125018.GA1673@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306125018.GA1673@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 01:50:18PM +0100, Pavel Machek wrote:

 > > The number of systems that actually *need* APIC enabled are in the
 > > vast (though growing) minority, so it's unlikely that most newbies
 > > will hit this.  The problem is also the inverse of what you describe.
 > > Typically the distros have DMI lists of machines that *need* APIC
 > > to make it enabled by default so everything 'just works'.
 > 
 > Well, blacklisting "new" machines is a problem -- their number
 > grows. Would not it be better to blacklist machines broken by APIC
 > ("old" ones, presumably)?

It would.  Though some new machines also falsely advertise it as
working aparently.  I heard a report of a thinkpad going boom last week.

 > Is adding "noapic nolapic" to default command line a big problem?

For end-users, yes.  People want things to 'just work', not have
to find arcane commands to type in to make things work.

		Dave


-- 
http://www.codemonkey.org.uk
