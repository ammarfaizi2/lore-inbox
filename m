Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266575AbTGFAZW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 20:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266577AbTGFAZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 20:25:22 -0400
Received: from gw.uk.sistina.com ([62.172.100.98]:24589 "EHLO
	gw.uk.sistina.com") by vger.kernel.org with ESMTP id S266575AbTGFAZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 20:25:19 -0400
Date: Sun, 6 Jul 2003 01:39:48 +0100
From: Alasdair G Kergon <agk@uk.sistina.com>
To: dm-devel@sistina.com
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [dm-devel] [RFC] device-mapper v4 ioctl interface implementation
Message-ID: <20030706013948.A19057@uk.sistina.com>
Mail-Followup-To: dm-devel@sistina.com,
	Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20030701145812.GA1596@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030701145812.GA1596@fib011235813.fsnet.co.uk>; from thornber@sistina.com on Tue, Jul 01, 2003 at 03:58:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 03:58:12PM +0100, Joe Thornber wrote:
> Following on from the header file for the v4 ioctl interface that I
> posted a couple of weeks ago, here is the first cut at the
> implementation (3 patches posted as a follow up to this mail).  I hope
> the v1 interface can be retired before 2.6.  Tools are not yet
> available to drive this, but should be later this week.
 
Updated device-mapper tools (dmsetup + libdevmapper) are now 
available for testing at:
  ftp://ftp.sistina.com/pub/LVM2/device-mapper/device-mapper-testing-new-version4-interface.tgz

This tarball also includes the complete device-mapper patches 
for 2.4.20 and 2.4.21, also available outside the tarball at:
  ftp://ftp.sistina.com/pub/LVM2/device-mapper/patches/combined*

Updated LVM2 tools to work alongside the above are at:
  ftp://ftp.sistina.com/pub/LVM2/tools/LVM2.0-testing.tgz

If the new tools detect the old version 1 driver, they try to
fall back and use the version 1 API, so you shouldn't
need to keep two sets of tools around if you're regularly
swapping kernels.  [But this hasn't been thoroughly tested.]

Alasdair
-- 
agk@uk.sistina.com
