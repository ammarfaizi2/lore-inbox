Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVKHISE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVKHISE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 03:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVKHISE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 03:18:04 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:54977 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932068AbVKHISB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 03:18:01 -0500
Date: Tue, 8 Nov 2005 13:47:58 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: noboru.obata.ar@hitachi.com
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] [KDUMP] pending interrupts problem
Message-ID: <20051108081758.GA2231@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <m13bmnc7jr.fsf@ebiederm.dsl.xmission.com> <20051101.181319.92587627.noboru.obata.ar@hitachi.com> <m1d5lk8uue.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d5lk8uue.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 04:34:49AM -0700, Eric W. Biederman wrote:
> OBATA Noboru <noboru.obata.ar@hitachi.com> writes:
> 

[..]
> > I think we need more test cases, especially the cases that focus
> > on "status" of hardware, to make kdump more reliable.  Kdump
> > should recover from all possible status of supported hardware.
> 
> Given that part of all possible status is broken hardware,
> that isn't necessarily possible. Still attempting to recover
> from all possible status is a sound plan.
> 
> > Is anyone working on developing such test cases for kdump?
> 
> Not to my knowledge.  The big push until just lately has simply
> been to get the core working.  Vivek Goyal would be the most
> likely suspect. But feel free to work on pathological scenarios.
> 

Currently I am trying to focus on fixing the already reported issues and
have not looked into special scenarios where kdump might fail. But your
effort in this direction is very much appreciated. We need to dig up such
corner cases to make kdump more reliable and robust.

Thanks
Vivek
