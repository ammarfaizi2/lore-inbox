Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbTIHNZg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbTIHNYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:24:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50909 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262279AbTIHNYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:24:03 -0400
Date: Thu, 4 Sep 2003 14:23:40 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 1151] New: 2.6.0 Test Kernel Fails to Build
Message-ID: <20030904122340.GQ1358@openzaurus.ucw.cz>
References: <49040000.1061924136@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49040000.1061924136@flay>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

http://bugme.osdl.org/show_bug.cgi?id=1151
> 
>            Summary: 2.6.0 Test Kernel Fails to Build
>     Kernel Version: 2.6.0-test4
>             Status: NEW
>           Severity: normal
>              Owner: ak@suse.de
>          Submitter: eklinger@uci.edu
> 
> 
> Distribution: Red Hat Enterprise AS Tyroon Beta
> Hardware Environment: Dual AMD Opteron 64-bit
> Software Environment: standard
> Problem Description: Kernel fails to build
> 
> Steps to reproduce: Configure kernel and compile. The error is below:
> 
> arch/x86_64/kernel/built-in.o(.text+0xcd7f): In function _do_suspend_lowlevel':
> : undefined reference to _save_processor_state'

Turn off CONFIG_PM; Im working on this.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

