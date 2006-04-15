Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWDOEZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWDOEZG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 00:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWDOEZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 00:25:05 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:30645 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1030219AbWDOEZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 00:25:04 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=n/5GVAxnWztwnWcudb2cHgzHaok1UG8PvlRaGtpdv3qPMKFm3SBz9FEPiHYVrDEPbmhRwE3Zq6wzfpZ1HLgP1tHS0qtS8oumagRqCu7d0Oghk6TApRVmzOTzvjroDAH3;
X-IronPort-AV: i="4.04,121,1144040400"; 
   d="scan'208"; a="617403:sNHT27183942"
Date: Fri, 14 Apr 2006 23:25:00 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: MrUmunhum@popdial.com, linux-kernel@vger.kernel.org
Subject: Re: Which device did I boot from?
Message-ID: <20060415042500.GB3250@lists.us.dell.com>
References: <44401071.5080700@popdial.com> <44401991.70100@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44401991.70100@keyaccess.nl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 11:52:17PM +0200, Rene Herman wrote:
> William Estrada wrote:
> 
> >Is there a way to determine which device I have booted from?  For
> >example, say I booted from a USB device, can I tell which one?  I did
> >not find anything in /proc FS other than the cmdline options.
> 
> If you choose the (experimental) CONFIG_EDD option in your kernel then, 
> with cooperation of your BIOS, you'll have a /sys/firmware/edd with at 
> least some info about the BIOS boot device. For me:

I suppose I should un-mark this as experimental.  It's been in the
kernel for a couple years, and shipping enabled in RHEL4 for over a
year with no problems (a recent buggy BIOS workaround the one
exception).

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
