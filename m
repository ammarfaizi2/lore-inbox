Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265924AbUAKRyq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 12:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUAKRyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 12:54:45 -0500
Received: from peabody.ximian.com ([130.57.169.10]:8346 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S265924AbUAKRyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 12:54:44 -0500
Subject: Re: Laptops & CPU frequency
From: Robert Love <rml@ximian.com>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1AfjdT-0008OH-00@chiark.greenend.org.uk>
References: <20040111025623.GA19890@ncsu.edu>
	 <20040111025623.GA19890@ncsu.edu> <1073791061.1663.77.camel@localhost>
	 <E1Afj2b-0004QN-00@chiark.greenend.org.uk>
	 <E1Afj2b-0004QN-00@chiark.greenend.org.uk>
	 <1073841200.1153.0.camel@localhost>
	 <E1AfjdT-0008OH-00@chiark.greenend.org.uk>
Content-Type: text/plain
Message-Id: <1073843690.1153.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sun, 11 Jan 2004 12:54:51 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-11 at 12:44, Matthew Garrett wrote:

> Is there any realistic way of noticing this sort of change?

Sure.  That is how Speedstep works, right?  We have an interface for
Speedstep, so the kernel knows about it.  We do not have an interface
for the proprietary BIOS stuff, I assume, so the kernel is oblivious.

But if you had the docs, I suppose you could code a solution and tie it
into the cpufreq code, just as we have proper support for Speedstep,
Longrun, etc.

	Robert Love


