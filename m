Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752119AbWAEIx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbWAEIx6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 03:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbWAEIx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 03:53:58 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:18077 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1751095AbWAEIx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 03:53:57 -0500
Date: Thu, 5 Jan 2006 03:55:59 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Dane Mutters <dmutters@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: (1) ACPI messes up Parallel support in kernels >2.6.9
Message-ID: <20060105085559.GA1357@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Dane Mutters <dmutters@gmail.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <200601042203.12377.dmutters@gmail.com> <20060104225209.56e35802.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104225209.56e35802.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 10:52:09PM -0800, Andrew Morton wrote:
> Dane Mutters <dmutters@gmail.com> wrote:
> >
> > 	I've been attempting to figure out this problem for a long time, and have 
> >  come to the conclusion that it must be a kernel bug (that or perhaps I'm a 
> >  bit dense).  Whenever I have the option, "Device Drivers > Plug and Play > 
> >  ACPI Support" enabled, I become unable to print using my parallel port.
> 
> hm, regressions are bad and the fact that it _used_ to work meand that we
> should be able to make it work again.
> 
> Could you please raise a bug reports against acpi at bugzilla.kernel.org? 
> It might help if that report includes the output of `dmesg -s 1000000' for
> both working and non-working kernels.
> 
> Thanks.

This may be a PnP bug.  If you can provide further information, I'll
look into it.

Thanks,
Adam

