Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVLAQzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVLAQzw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVLAQzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:55:52 -0500
Received: from fsmlabs.com ([168.103.115.128]:49036 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932333AbVLAQzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:55:51 -0500
X-ASG-Debug-ID: 1133456149-23768-13-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 1 Dec 2005 09:01:29 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: Enabling RDPMC in user space by default
Subject: Re: Enabling RDPMC in user space by default
In-Reply-To: <20051201130518.GD19515@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0512010854100.13220@montezuma.fsmlabs.com>
References: <20051129151515.GG19515@wotan.suse.de>
 <Pine.LNX.4.61.0511291837050.17356@montezuma.fsmlabs.com>
 <20051130033808.GJ19515@wotan.suse.de> <Pine.LNX.4.61.0511292030580.17356@montezuma.fsmlabs.com>
 <20051201130518.GD19515@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5757
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2005, Andi Kleen wrote:

> > I agree that the NMI watchdog is very important, but my main objection is 
> > trying to provide a stable interface for this, i would rather see a 
> > seperate tool do it (as cumbersome as it may be) even if it meant that 
> > the external tool simply did what you intend on doing in the kernel.
> 
> But why an external tool when the nmi watchdog needs this anyways?

We'll probably have the NMI watchdog ticking at a lower frequency anyway 
and isn't always enabled. Although i recall you want NMI watchdog on by 
default too on i386 (which i don't have a problem with). The reason for 
the external tool is because that allows more flexibility for profiling 
tools, that is more PMCs can be used if needed by the user.

