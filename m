Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932727AbWCAAGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbWCAAGS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 19:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932728AbWCAAGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 19:06:18 -0500
Received: from liaag1ag.mx.compuserve.com ([149.174.40.33]:30661 "EHLO
	liaag1ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932727AbWCAAGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 19:06:17 -0500
Date: Tue, 28 Feb 2006 19:03:13 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: port ATI timer fix from x86_64 to i386
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Message-ID: <200602281905_MC3-1-B97E-7FDC@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060228152124.616e6c1c.akpm@osdl.org>

On Tue, 28 Feb 2006 15:21:24, Andrew Morton wrote:

> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> >
> > Disable timer routing over 8254 when an ATI chipset is detected
> >  (autodetect is only implemented for ACPI, but these are new systems
> >  and should be using ACPI anyway.)  Adds boot options for manually
> >  disabling and enabling this feature. Also adds a note to the timer
> >  error message caused by this change explaining that this error
> >  is expected on ATI chipsets.
> 
> umm, why did you write this patch?  Presumably it's fixing something, but
> what?

Oops...  I'm here in the middle of the forest and all I can see are trees.

This fixes the "timer runs too fast" bug on ATI chipsets (bugzilla #3927).


-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

