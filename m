Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWBGWoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWBGWoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWBGWns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:43:48 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:29881 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1030181AbWBGWnq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:43:46 -0500
Date: Tue, 7 Feb 2006 15:43:44 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Keith Owens <kaos@sgi.com>
Cc: Adrian Bunk <bunk@stusta.de>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] IA64_GENERIC shouldn't select other stuff
Message-ID: <20060207224344.GF1601@parisc-linux.org>
References: <20060207221157.GA3524@stusta.de> <9883.1139351831@ocs3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9883.1139351831@ocs3>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 09:37:11AM +1100, Keith Owens wrote:
> A generic IA64 kernel requires (at least) the ACPI and NUMA options in
> order to run on all the IA64 platforms out there.  Omitting those
> options and relying on the user to set them by hand is going to cause
> more problems.

I'm not sure about that.  If the user selects a specific type of machine,
ACPI doesn't get selected for them -- even when it's needed to boot.
It's certainly inconsistent and should be fixed one way or the other.
