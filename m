Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWJVSLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWJVSLX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 14:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWJVSLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 14:11:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55686 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750833AbWJVSLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 14:11:22 -0400
Date: Sun, 22 Oct 2006 14:11:02 -0400
From: Dave Jones <davej@redhat.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Michael Buesch <mb@bu3sch.de>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: NULL pointer dereference in sysfs_readdir
Message-ID: <20061022181102.GC27152@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Michael Buesch <mb@bu3sch.de>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org
References: <4539DDC5.80207@s5r6.in-berlin.de> <200610212204.56772.mb@bu3sch.de> <453A8CA7.5070108@s5r6.in-berlin.de> <200610212325.18976.mb@bu3sch.de> <453B352A.5050700@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453B352A.5050700@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 11:08:58AM +0200, Stefan Richter wrote:

 > What if "next" became NULL afterwards? I know it's unlikely (but so is
 > the whole bug, given that we have just one reporter despite the bug's
 > age), but is it impossible? IOW does sysfs_readdir have any indirect
 > mutex protection?
 > 
 > Dave, do you patch sysfs datatypes in FC's kernel, or types they include?

Not that I recall. <linux/sysfs.h> is untouched in the trees I just
looked at (only have .18 ones handy right now)

	Dave

-- 
http://www.codemonkey.org.uk
