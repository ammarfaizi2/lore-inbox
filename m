Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUCKRcy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 12:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbUCKRcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 12:32:53 -0500
Received: from mill.mtholyoke.edu ([138.110.30.76]:5762 "EHLO
	mill.mtholyoke.edu") by vger.kernel.org with ESMTP id S261181AbUCKRcs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 12:32:48 -0500
From: Ron Peterson <rpeterso@mtholyoke.edu>
Date: Thu, 11 Mar 2004 12:32:29 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: network/performance problem
Message-ID: <20040311173229.GA12325@mtholyoke.edu>
References: <20040311152728.GA11472@mtholyoke.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311152728.GA11472@mtholyoke.edu>
User-Agent: Mutt/1.3.28i
Organization: Mount Holyoke College
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 10:27:28AM -0500, rpeterso wrote:

> I've been perusing fa.linux.kernel, and saw Brad Laue's thread.  FWIW,
> it smells similar.  When my machines finally go down, ksoftirqd is
> always at the top of the process list.
> 
> Any ideas at all about what might be happening?

I put my latest user.log file up (16M):

http://depot.mtholyoke.edu:8080/tmp/sam-profile/user.log

If you 'grep PSTOPCPU user.log | less', you can see that ksoftirqd_CPU0
slowly but steadily consumes a higher and higher CPU percentage.  What
this means, I have no idea.

-- 
Ron Peterson
Network & Systems Manager
Mount Holyoke College
http://www.mtholyoke.edu/~rpeterso
