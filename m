Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVH3RHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVH3RHG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVH3RHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:07:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31941 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932214AbVH3RHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:07:04 -0400
Date: Tue, 30 Aug 2005 13:06:00 -0400
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386, x86_64 Initial PAT implementation
Message-ID: <20050830170600.GA10042@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@suse.de>
References: <m1psrwmg10.fsf@ebiederm.dsl.xmission.com> <1125413136.8276.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125413136.8276.14.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 03:45:36PM +0100, Alan Cox wrote:
 > On Llu, 2005-08-29 at 18:20 -0600, Eric W. Biederman wrote:
 > > ways.  Currently this code only allows for an additional flavor
 > > of uncached access to physical memory addresses which should be hard
 > > to abuse, and should raise no additional aliasing problems.  No
 > > attempt has been made to fix theoretical aliasing problems.
 > 
 > Even an uncached/cached alias causes random memory corruption or an MCE
 > on x86 systems. In fact it can occur even for an alias not in theory
 > touched by the CPU if it happens to prefetch into or speculate the
 > address.
 > 
 > Also be sure to read the PII Xeon errata - early PAT has a bug or two.

There are various PAT errata all the way through to Pentium-M iirc.

		Dave

