Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266437AbTGERPo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 13:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266439AbTGERPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 13:15:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11969 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266437AbTGERPm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 13:15:42 -0400
Message-ID: <3F070B1A.2090901@pobox.com>
Date: Sat, 05 Jul 2003 13:30:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Reply-To: jgarzik@pobox.com
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [ANN] rng-tools 1.0 released
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 1.0 of the rng-tools package has been released to

	http://sourceforge.net/projects/gkernel

This is the userspace support package for i810_rng / amd768_rng (2.4) 
and hw_random (2.5) device drivers.

The general idea is that you have a userspace daemon obtaining random 
data from one or more sources, run it through a bunch of "make sure it's 
really random" sanity checks, and then add that entropy to the kernel's 
/dev/random entropy pool.

Future directions include Via RNG support completely in userspace, and 
support for entropy sources other than a single /dev file.

Contributions and critical review of this package welcome.

	Jeff


P.S.  Future release announcements will occur only via SourceForge's 
automated release notification system.  This is a fairly minor package, 
and I don't want to spam lkml.

