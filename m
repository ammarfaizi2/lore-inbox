Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbTDOXRN (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 19:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTDOXRM 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 19:17:12 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60912 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264154AbTDOXRM 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 19:17:12 -0400
Date: Tue, 15 Apr 2003 16:25:15 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: walt <wa1ter@myrealbox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
Message-ID: <20030415162515.A362@beaverton.ibm.com>
References: <fa.chdor2j.u72387@ifi.uio.no> <fa.gs8uudl.196640l@ifi.uio.no> <3E9C8FE2.8040001@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E9C8FE2.8040001@myrealbox.com>; from wa1ter@myrealbox.com on Tue, Apr 15, 2003 at 04:04:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 04:04:02PM -0700, walt wrote:

> Yes!  Thank you.  This patch fixes the segfault of modprobe that I've 
> been seeing for ages.
> 
> Note that the problems I have been seeing are completely different from 
> Geert's problems.  I have had no problems mounting a FAT-16 fs with the 
> 2.5.x kernels but modprobe has been segfaulting all along, even though 
> the ppa module works fine for me once it has been loaded.

The other problem seems to be for removable media. Is your parallel zip
have removable media and does the boot/dmesg output from sd attach show it
as such? I haven't used a zip drive, I thought they had to be marked
removable.

-- Patrick Mansfield
