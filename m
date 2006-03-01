Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWCANiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWCANiR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWCANiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:38:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45513 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932119AbWCANiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:38:16 -0500
Date: Wed, 1 Mar 2006 08:38:09 -0500
From: Dave Jones <davej@redhat.com>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [PATCH] leave APIC code inactive by default on i386
Message-ID: <20060301133809.GA16840@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Michael Ellerman <michael@ellerman.id.au>,
	"Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
	Chris McDermott <lcm@us.ibm.com>
References: <43D03AF0.3040703@us.ibm.com> <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com> <20060301043353.GJ28434@redhat.com> <200603011610.31090.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603011610.31090.michael@ellerman.id.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 04:10:26PM +1100, Michael Ellerman wrote:
 > > The number of systems that actually *need* APIC enabled are in the
 > > vast (though growing) minority, so it's unlikely that most newbies
 > > will hit this.  The problem is also the inverse of what you describe.
 > > Typically the distros have DMI lists of machines that *need* APIC
 > > to make it enabled by default so everything 'just works'.
 > 
 > Ok, even more reason for it to go in. Someone might want to let the folks at 
 > Ubuntu know too, they seem to have it enabled in their installer kernel. :D

Last I looked they picked up the same patch we were carrying in Fedora.

		Dave

