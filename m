Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUCKPac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUCKPaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:30:07 -0500
Received: from mill.mtholyoke.edu ([138.110.30.76]:46977 "EHLO
	mill.mtholyoke.edu") by vger.kernel.org with ESMTP id S261440AbUCKP1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:27:47 -0500
From: Ron Peterson <rpeterso@mtholyoke.edu>
Date: Thu, 11 Mar 2004 10:27:28 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: network/performance problem
Message-ID: <20040311152728.GA11472@mtholyoke.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Mount Holyoke College
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't reboot sam like I said I would.  I decided I'd let it spiral
down.  I'm still collecting profile data every fifteen minutes.  I
haven't posted any more graphs.  They look the same as all the others: a
monotonically increasing ping latency (w/ a corresponding slow increase
in system load averages - which I'm logging, if anyone wants more data).

http://depot.mtholyoke.edu:8080/tmp/sam-profile/

I've been perusing fa.linux.kernel, and saw Brad Laue's thread.  FWIW,
it smells similar.  When my machines finally go down, ksoftirqd is
always at the top of the process list.

Any ideas at all about what might be happening?

-- 
Ron Peterson
Network & Systems Manager
Mount Holyoke College
http://www.mtholyoke.edu/~rpeterso
