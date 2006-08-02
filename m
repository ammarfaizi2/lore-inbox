Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWHBEqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWHBEqt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 00:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWHBEqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 00:46:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58044 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751170AbWHBEqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 00:46:48 -0400
Date: Wed, 2 Aug 2006 00:46:39 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: frequent slab corruption (since a long time)
Message-ID: <20060802044639.GB30216@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <20060802021617.GH22589@redhat.com> <p73fygfzu2v.fsf@verdi.suse.de> <20060802042200.GA30216@redhat.com> <200608020635.00991.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608020635.00991.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 06:35:00AM +0200, Andi Kleen wrote:
 > On Wednesday 02 August 2006 06:22, Dave Jones wrote:
 > 
 > > Problem with that approach is that DEBUG_PAGEALLOC makes things
 > > so damned slow that it's pretty much unusable, and this bug
 > > doesn't seem to want to repeat itself to order, so I doubt
 > > many people would put up with the slowdown long enough to chase it down.
 > 
 > Really?  It shouldn't be that much slower in theory. Do you
 > have numbers?

You need slower boxes :-)

Every time I enable it to try and diagnose a bug in the Fedora kernel
I get a flood of "hey what gives, everything got slow" emails.
That speaks louder than any numbers to me.

It could be less of an issue on modern CPUs than it used to be, but
it has been painful enough in the past that I've really only enabled
it when I've been desperately trying to chase something down.

 > If it's a big problem it could probably be made faster by batching
 > the TLB flushes more.

Maybe, though that gives me the creeps a little for some reason.

		Dave

-- 
http://www.codemonkey.org.uk
