Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbUCYOZh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 09:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUCYOZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 09:25:17 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47578 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263164AbUCYOYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 09:24:51 -0500
Date: Tue, 23 Mar 2004 10:56:01 +0100
From: Pavel Machek <pavel@suse.cz>
To: Kenneth Chen <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: add lowpower_idle sysctl
Message-ID: <20040323095600.GE1505@openzaurus.ucw.cz>
References: <200403180031.i2I0VQF02038@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403180031.i2I0VQF02038@unix-os.sc.intel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On ia64, we need runtime control to manage CPU power state in the idle
> loop.  Logically it means a sysctl entry in /proc/sys/kernel.  Even
> though this sysctl entry doesn't exist today, lots of arch already has
> some sort of API to dynamically enable/disable low power idle state.

If you make it "max Cx state to allow", it will be usefull for ACPI people, too...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

