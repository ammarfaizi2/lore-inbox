Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWBXCL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWBXCL3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 21:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWBXCL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 21:11:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15234 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932318AbWBXCL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 21:11:28 -0500
Date: Thu, 23 Feb 2006 21:11:19 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Make SMP x86-64 kernels boot on more UP systems.
Message-ID: <20060224021119.GI23471@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060224014112.GA16089@redhat.com> <200602240245.01417.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602240245.01417.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 02:45:00AM +0100, Andi Kleen wrote:
 > On Friday 24 February 2006 02:41, Dave Jones wrote:
 > > Should someone boot an SMP kernel on UP hardware on some systems,
 > > strange things happen, such as..
 > Boot logs?

https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=124341

 > > SMP: Allowing 0 CPUs.
 > > 
 > > We blow up shortly afterwards.
 > > 
 > > Signed-off-by: Dave Jones <davej@redhat.com>

revisiting the bug, I'm not 100% sure my patch was the actual
fix or just something cosmetic, as I changed other things
too in subsequent kernels. I'll get the user to double check it.

		Dave

