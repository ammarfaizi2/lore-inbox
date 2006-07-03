Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWGCVoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWGCVoL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWGCVoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:44:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5279 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750852AbWGCVoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:44:09 -0400
Date: Mon, 3 Jul 2006 17:44:03 -0400
From: Dave Jones <davej@redhat.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] Add Dothan frequency tables for speedstep
Message-ID: <20060703214403.GP14292@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <44A98250.6060508@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A98250.6060508@oracle.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 01:47:12PM -0700, Randy Dunlap wrote:
 > 
 > Patch to Add Dothan frequency tables for speedstep.

Already NAK'd at least a half dozen times.

Yes it works great if your system is wired up to use VID#C,
but what if it isn't ?  It's got a 1 in 4 chance of working,
and what it'll do in the other 3 cases is anyones guess.

As there's no way to tell which VID is in use, the only
option on these systems is to use either the acpi
mode of this driver, or acpi-cpufreq instead.

		Dave

-- 
http://www.codemonkey.org.uk
