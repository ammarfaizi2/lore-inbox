Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270855AbTHGUrG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270863AbTHGUrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:47:06 -0400
Received: from holomorphy.com ([66.224.33.161]:16022 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270855AbTHGUrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:47:01 -0400
Date: Thu, 7 Aug 2003 13:48:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Interactivity improvements
Message-ID: <20030807204817.GZ32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <3F3261A2.9000405@cs.ubishops.ca> <20030807152418.GA509@malvern.uk.w2k.superh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807152418.GA509@malvern.uk.w2k.superh.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McLean <pmclean@cs.ubishops.ca> [2003-08-07]:
>> Another point is compilers, they tend to do a lot of disk I/O then 
>> become major CPU hogs, could we have some sort or heuristic that reduces 
>> the bonuses for sleeping on block I/O rather than other kinds of I/O 
>> (say pipes and network I/O in the case of X).

On Thu, Aug 07, 2003 at 04:24:18PM +0100, Richard Curnow wrote:
> What about compilers chewing on source files coming in over NFS rather
> than resident on local block devices?  The network waits need to be
> broken out into NFS versus other, or UDP versus TCP or something.  e.g.
> waits due to the user not having typed anything yet, or moved the mouse,
> are going to be on TCP connections.

I'd be interested in whatever you come up with for this, as I use NFSS
a lot.


-- wli
