Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWCSTkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWCSTkH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 14:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWCSTkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 14:40:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:17024 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750763AbWCSTkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 14:40:06 -0500
Date: Sun, 19 Mar 2006 19:40:04 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, kernel-stuff@comcast.net,
       linux-kernel@vger.kernel.org, alex-kernel@digriz.org.uk,
       jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Message-ID: <20060319194004.GZ27946@ftp.linux.org.uk>
References: <200603181525.14127.kernel-stuff@comcast.net> <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org> <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org> <Pine.LNX.4.64.0603191034370.3826@g5.osdl.org> <Pine.LNX.4.64.0603191050340.3826@g5.osdl.org> <Pine.LNX.4.64.0603191125220.3826@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603191125220.3826@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2006 at 11:33:17AM -0800, Linus Torvalds wrote:
> Doing a "break" inside a conditional by using the gcc statement 
> expressions is sublime. 
> 
> And it works.

In the version of gcc you've tested.  With options and phase of moon
being what they had been.  IOW, you are awfully optimistic - it's not
just using gcc extension, it's using undocumented (in the best case)
behaviour outside the intended use of that extension.
