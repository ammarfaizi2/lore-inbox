Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWCAWON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWCAWON (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWCAWON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:14:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29597 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751077AbWCAWON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:14:13 -0500
Date: Wed, 1 Mar 2006 17:14:04 -0500
From: Dave Jones <davej@redhat.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, linux-kernel@vger.kernel.org,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [PATCH] leave APIC code inactive by default on i386
Message-ID: <20060301221404.GA1440@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Darrick J. Wong" <djwong@us.ibm.com>,
	Michael Ellerman <michael@ellerman.id.au>,
	linux-kernel@vger.kernel.org, Chris McDermott <lcm@us.ibm.com>
References: <43D03AF0.3040703@us.ibm.com> <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com> <20060301043353.GJ28434@redhat.com> <1141248546.30185.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141248546.30185.44.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 01:29:06PM -0800, Darrick J. Wong wrote:
 > On Tue, 2006-02-28 at 23:33 -0500, Dave Jones wrote:
 > 
 > > It's still being kicked around.  I saw one patch off-list earlier this
 > > week that has some small improvements over the variant originally posted,
 > > but still had 1-2 kinks.
 > 
 > Hm... what kinks are you referring to?  Anything you want me to look at?

I think Konrad was on top of it, mostly just confusion over variants
of the same diff leading to things previously fixed being dropped again.

In light of Matthew's comments in this thread though, I'm also wondering
if we can now get by without this diff, and just enable it by default now
that the kernel respects that the BIOS and leaves it alone if it's been
disabled.

		Dave

