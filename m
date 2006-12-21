Return-Path: <linux-kernel-owner+w=401wt.eu-S1161168AbWLUIJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161168AbWLUIJN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161172AbWLUIJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:09:13 -0500
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:54704 "EHLO
	liaag2ae.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161168AbWLUIJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:09:12 -0500
Date: Thu, 21 Dec 2006 03:05:23 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Oops in 2.6.19.1
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200612210308_MC3-1-D5D4-3328@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200612202215.50315.s0348365@sms.ed.ac.uk>

On Wed, 20 Dec 2006 22:15:50 +0000, Alistair John Strachan wrote:

> > I'd guess you have some kind of hardware problem.  It could also be
> > a kernel problem where the saved address was corrupted during an
> > interrupt, but that's not likely.
> 
> Seems pretty unlikely on a 4 year old Via Epia. Never had any problems with it 
> before now.
> 
> Maybe a cosmic ray event? ;-)

The low byte of eip should be 5f and it changed to 60, so that's
probably not it.  And the oops report is consistent with that being
the instruction that was really executed, so it's not the kernel
misreporting the address after it happened.

You weren't trying kprobes or something, were you? Have you ever
had another unexplained oops with this machine?

-- 
MBTI: IXTP

