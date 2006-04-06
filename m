Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWDFC6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWDFC6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 22:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWDFC6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 22:58:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40914 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750841AbWDFC6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 22:58:10 -0400
Date: Thu, 6 Apr 2006 12:57:56 +1000
From: Nathan Scott <nathans@sgi.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-xfs@oss.sgi.com
Subject: Re: Bonnie++ Burps on XFS
Message-ID: <20060406125756.H1110920@wobbly.melbourne.sgi.com>
References: <20060406023445.GB5806@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060406023445.GB5806@kurtwerks.com>; from kwall@kurtwerks.com on Wed, Apr 05, 2006 at 10:34:45PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 10:34:45PM -0400, Kurt Wall wrote:
> I've been using bonnie++ off and on for a long time. Suddenly, it has
> started failing when run against an XFS filesystem situated on a SATA
> drive. Here's the output of a run:

[ Please report these things to linux-xfs@oss.sgi.com... ]

> Delete files in sequential order...Bonnie: drastic I/O error (rmdir):

Anything in your system log?

> clear if the problems is XFS, some other piece of the kernel, or
> bonnie++. Neither dmesg nor syslog shows anything amiss. I suppose 
> I could strace the run, but I'm not especially eager to deal with 
> a multi-gigabyte output file if there is a more focused method to
> isolate the problem.

See if 2.6.16.1 fails too for starters then we'll take it from there.

cheers.

-- 
Nathan
