Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbTFIPGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 11:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTFIPGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 11:06:41 -0400
Received: from ip68-107-142-198.tc.ph.cox.net ([68.107.142.198]:32427 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP id S264449AbTFIPGk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 11:06:40 -0400
Date: Mon, 9 Jun 2003 08:20:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 791] New: motorola sandpoint code does not compile
Message-ID: <20030609152018.GE28745@ip68-0-152-218.tc.ph.cox.net>
References: <39560000.1055169517@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39560000.1055169517@[10.10.2.4]>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 07:38:37AM -0700, Martin J. Bligh wrote:

>            Summary: motorola sandpoint code does not compile
>     Kernel Version: 2.5.70
>             Status: NEW
>           Severity: normal
>              Owner: bugme-janitors@lists.osdl.org
>          Submitter: thomas@koeller.dyndns.org
> 
> 
> Distribution: none 
> Hardware Environment: Motorola Sandpoint X3 /w Unity/8240 MPPMC 
> Software Environment: Cross build on Linux/x86 host using gcc-3.3 
> Problem Description: arch/ppc/platforms/sandpoint_setup.c does not compile because 
> the call to openpic_init() in line #309 does not match the punction prototype as defined 
> in include/asm-ppc/open_pic.h 
>  
> Steps to reproduce: Configure for Sandpoint X3 target and build.

The Motorola Sandpoint code (along with many other MPC107 based
platforms) is out of date in 2.5.  Is there a way to close this bug and
have it reflect that?

-- 
Tom Rini
http://gate.crashing.org/~trini/
