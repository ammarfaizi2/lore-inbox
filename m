Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWCAPyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWCAPyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 10:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWCAPyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 10:54:31 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:16262 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932419AbWCAPya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 10:54:30 -0500
Date: Wed, 1 Mar 2006 10:50:26 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: port ATI timer fix from x86_64 to i386
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, Andi Kleen <ak@suse.de>
Message-ID: <200603011053_MC3-1-B997-3BA2@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060301025219.2034924c.akpm@osdl.org>

On Wed, 1 Mar 2006 02:52:19, Andrew Morton wrote:

> > 
> > Still it's probably a good idea for 2.6.16.
> > 
> 
> Well..  the patch had a flagrant won't-compile if CONFIG_X86_IO_APIC=y, so
> I'd consider it a bit green.

Aargh... I hit that and fixed it, but forgot to refresh before sending.

The only thing I didn't test was whether the boot options worked, and
I just did that -- 'enable_8254_timer' makes the clock run too fast as
expected.

And credit to Andi was implicit in the "port from x86_64" but it should
have been explicit.


-- 
Chuck
"The sleet in Crete falls neatly in the street."

