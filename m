Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUCKSVp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbUCKSVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:21:33 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:8258 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261624AbUCKSVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:21:08 -0500
From: Richard Browning <richard@redline.org.uk>
Organization: Redline Software Engineering
To: Len Brown <len.brown@intel.com>
Subject: Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel 2.4.x 2.6.x / Crash/Freeze
Date: Thu, 11 Mar 2004 18:19:25 +0000
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, Zwane Mwaikambo <zwane@linuxpower.ca>
References: <A6974D8E5F98D511BB910002A50A6647615F4B99@hdsmsx402.hd.intel.com> <1078987834.2556.84.camel@dhcppc4>
In-Reply-To: <1078987834.2556.84.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403111819.25819.richard@redline.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 March 2004 06:50, Len Brown wrote:
> On Wed, 2004-03-10 at 07:27, Richard Browning wrote:
> > When operating from the
> > command line it is usual to see a Machine Check Exception error
> > immediately prior to system failure.
>
> details?

I've now updated the BIOS to the latest version available on Asus' site. The 
crash occurs even earlier - during bootup this time. Exactly:

CPU2: Machine Check Exception: 000.0004
CPU3: Machine Check Exception: 000.0004
Bank 0: a20000008c010400Bank0: a20000008c010400
Kernel Panic: CPU context corrupt
In idle task - not syncing

Again, disabling hyperthreading allows the system to operate normally.

R
