Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWCANw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWCANw2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWCANw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:52:28 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:19840 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S932170AbWCANw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:52:27 -0500
To: Dave Jones <davej@redhat.com>
Cc: Michael Ellerman <michael@ellerman.id.au>,
       "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [PATCH] leave APIC code inactive by default on i386
In-Reply-To: <20060301133809.GA16840@redhat.com>
References: <43D03AF0.3040703@us.ibm.com> <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com> <20060301043353.GJ28434@redhat.com> <200603011610.31090.michael@ellerman.id.au> <200603011610.31090.michael@ellerman.id.au> <20060301133809.GA16840@redhat.com>
Date: Wed, 1 Mar 2006 13:52:16 +0000
Message-Id: <E1FERkW-0003Eb-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
> On Wed, Mar 01, 2006 at 04:10:26PM +1100, Michael Ellerman wrote:
> > 
> > Ok, even more reason for it to go in. Someone might want to let the folks at 
> > Ubuntu know too, they seem to have it enabled in their installer kernel. :D
> 
> Last I looked they picked up the same patch we were carrying in Fedora.

No, we use the standard kernel behaviour (use APIC if the BIOS enabled 
it, otherwise don't). 

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
