Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbTDIRFd (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 13:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbTDIRFd (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 13:05:33 -0400
Received: from holomorphy.com ([66.224.33.161]:36778 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263618AbTDIRFc (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 13:05:32 -0400
Date: Wed, 9 Apr 2003 10:16:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hermann Himmelbauer <dusty@violin.dyndns.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.20 on a 4 MB Laptop
Message-ID: <20030409171650.GA30376@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hermann Himmelbauer <dusty@violin.dyndns.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200304091601.55821.dusty@violin.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304091601.55821.dusty@violin.dyndns.org>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 04:01:55PM +0200, Hermann Himmelbauer wrote:
> I currently try installing Linux on an old IBM Laptop. (IBM Thinkpad 340, 
> 486SLC 25/50 from 1994). The laptop only has 4 MB RAM, so I installed a 
> simple Linux distribution on a better computer, recompiled Linux 2.4.20 and 
> stripped out everything I could (with menuconfig): No networking. FPU 
> emulation. The only "luxury" I left is "ext3" - perhaps this uses a lot of 
> memory?
> Well - anyway, the kernel boots but right stops after:
> INIT: Entering runlevel:3
> The next line is:
> INIT: open(/dev/console): Input/output error
> INIT: Id "2" respawning too fast: disabled for 5 minutes
> ...
> That's it.
> What I want to know is if this happens just because of the low memory (4MB) or 
> if there is another reason for this behaviour.
> What do you think: What are the minimum requirements for Linux on such a 
> laptop (no X, of course, very simple setup): 8MB, 12MB?

Try using init=/bin/sh, doing swapon manually, and then exec /sbin/init

-- wli
