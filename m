Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbTISA6o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 20:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbTISA6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 20:58:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:62872 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262213AbTISA6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 20:58:43 -0400
Date: Thu, 18 Sep 2003 17:58:42 -0700
From: Mark Wong <markw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linstab@osdl.org
Subject: Re: [Linstab] Hackbench STP Results History for 2.5 mm/2.6 mm
Message-ID: <20030918175842.A21411@osdlab.pdx.osdl.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linstab@osdl.org
References: <200309190012.h8J0ClU15905@mail.osdl.org> <20030918170754.6164e770.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030918170754.6164e770.akpm@osdl.org>; from akpm@osdl.org on Thu, Sep 18, 2003 at 05:07:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 18, 2003 at 05:07:54PM -0700, Andrew Morton wrote:
> markw@osdl.org wrote:
> >
> > More history from hackbench from STP from the 2.5 and 2.6 mm kernels.
> 
> This looks great, but tragically incomprehensible.
> 
> Could someone please provide some interpretation, tell us what hackbench
> is, and what all the numbers mean?
> 
> Do we rock or do we suck?

Sorry, I was a bit hasty.

Hackbench is a test from Rusty Russel that's intended to test the scalability
of the scheduler.  The results I gathered are from a test where 100 processes
are started to send a message to another set of 100 processes.  This is
repeated at least a few times and the time taken to complete each instance
is averaged.  Anyone feel free to correct me as I learned this second hand.

The general trend in the metric indicates everything has been improving, so I
think we rock.
